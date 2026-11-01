require "test_helper"

class TasksTest < ActionDispatch::IntegrationTest
  setup { sign_in_as users(:alice) }

  test "creates a task" do
    assert_difference "lists(:home).tasks.count", 1 do
      post list_tasks_path(lists(:home)), params: { task: { title: "Comprar pan", priority: "high", due_on: Date.current } }
    end

    task = lists(:home).tasks.find_by!(title: "Comprar pan")
    assert task.priority_high?
    assert_equal Date.current, task.due_on
    assert_redirected_to list_path(lists(:home))
  end

  test "does not create a task without a title" do
    assert_no_difference "Task.count" do
      post list_tasks_path(lists(:home)), params: { task: { title: "" } }
    end
    assert flash[:alert].present?
  end

  test "redirects back to the page the task was created from" do
    post list_tasks_path(lists(:home)), params: { task: { title: "X" } }, headers: { "HTTP_REFERER" => root_url }
    assert_redirected_to root_url
  end

  test "toggles a task" do
    patch toggle_task_path(tasks(:dishes))
    assert tasks(:dishes).reload.completed?

    patch toggle_task_path(tasks(:dishes))
    assert_not tasks(:dishes).reload.completed?
  end

  test "renders the inline edit form" do
    get edit_task_path(tasks(:dishes))
    assert_response :success
    assert_select "turbo-frame#task_#{tasks(:dishes).id} form"
  end

  test "updates a task" do
    patch task_path(tasks(:dishes)), params: { task: { title: "Fregar", notes: "Con jabón", priority: "low" } }
    task = tasks(:dishes).reload
    assert_equal "Fregar", task.title
    assert_equal "Con jabón", task.notes
    assert task.priority_low?
  end

  test "destroys a task" do
    assert_difference "Task.count", -1 do
      delete task_path(tasks(:dishes))
    end
  end

  test "reorders tasks" do
    patch sort_tasks_path, params: { ids: [ tasks(:laundry).id, tasks(:dishes).id ] }
    assert_response :no_content
    assert_equal 0, tasks(:laundry).reload.position
    assert_equal 1, tasks(:dishes).reload.position
  end

  test "cannot touch tasks of another user" do
    secret = tasks(:secret)

    get edit_task_path(secret)
    assert_response :not_found

    patch task_path(secret), params: { task: { title: "Hackeada" } }
    assert_response :not_found
    assert_equal "Tarea privada de Bob", secret.reload.title

    patch toggle_task_path(secret)
    assert_response :not_found
    assert_not secret.reload.completed?

    assert_no_difference "Task.count" do
      delete task_path(secret)
    end

    post list_tasks_path(lists(:bobs)), params: { task: { title: "Intrusa" } }
    assert_response :not_found
  end
end
