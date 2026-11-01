require "test_helper"

class ListsTest < ActionDispatch::IntegrationTest
  setup { sign_in_as users(:alice) }

  test "home shows the overview with overdue and due-today tasks" do
    get root_path
    assert_response :success
    assert_select "h2", text: /Vencidas/
    assert_select "h2", text: /Para hoy/
    assert_select "li", text: /Llamar al fontanero/
  end

  test "shows a list with its tasks" do
    get list_path(lists(:home))
    assert_response :success
    assert_select "h1", "Casa"
    assert_select "li", text: /Fregar los platos/
    assert_select "details", text: /Completadas \(1\)/
  end

  test "creates a list" do
    assert_difference "users(:alice).lists.count", 1 do
      post lists_path, params: { list: { name: "Viajes", icon: "✈️", color: "sky" } }
    end
    assert_redirected_to list_path(List.find_by!(name: "Viajes"))
  end

  test "does not create an invalid list" do
    assert_no_difference "List.count" do
      post lists_path, params: { list: { name: "", icon: "✈️", color: "sky" } }
    end
    assert flash[:alert].present?
  end

  test "updates a list" do
    patch list_path(lists(:home)), params: { list: { name: "Hogar", color: "rose" } }
    assert_equal "Hogar", lists(:home).reload.name
    assert_equal "rose", lists(:home).color
  end

  test "destroys a list and its tasks" do
    assert_difference [ "List.count" ], -1 do
      assert_difference "Task.count", -4 do
        delete list_path(lists(:home))
      end
    end
    assert_redirected_to root_path
  end

  test "clears completed tasks" do
    assert_difference "Task.count", -1 do
      delete clear_completed_list_path(lists(:home))
    end
    assert_not Task.exists?(title: "Declaración hecha")
  end

  test "reorders lists" do
    patch sort_lists_path, params: { ids: [ lists(:work).id, lists(:home).id ] }
    assert_response :no_content
    assert_equal 0, lists(:work).reload.position
    assert_equal 1, lists(:home).reload.position
  end

  test "cannot access, modify or reorder another user's lists" do
    other = lists(:bobs)

    get list_path(other)
    assert_response :not_found

    patch list_path(other), params: { list: { name: "Hackeada" } }
    assert_response :not_found
    assert_equal "Lista de Bob", other.reload.name

    assert_no_difference "List.count" do
      delete list_path(other)
    end
    assert_response :not_found

    patch sort_lists_path, params: { ids: [ other.id ] }
    assert_equal 0, other.reload.position
  end
end
