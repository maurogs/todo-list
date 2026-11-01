require "application_system_test_case"

class TodoFlowTest < ApplicationSystemTestCase
  setup { sign_in_through_the_form users(:alice) }

  test "adds, completes, edits and deletes a task without leaving the page shell" do
    click_on "Casa", match: :first
    assert_selector "h1", text: "Casa"

    fill_in "Título de la tarea", with: "Comprar bombillas"
    click_on "Añadir tarea"
    assert_selector "li", text: "Comprar bombillas"
    assert_field "Título de la tarea", with: ""

    within(:xpath, "//li[.//p[text()='Comprar bombillas']]") do
      click_on "Marcar como completada"
    end
    assert_selector "details li", text: "Comprar bombillas"

    within(:xpath, "//li[.//p[text()='Comprar bombillas']]") do
      click_on "Editar tarea"
      fill_in "Título", with: "Comprar bombillas LED"
      click_on "Guardar"
    end
    assert_selector "li", text: "Comprar bombillas LED"

    within(:xpath, "//li[.//p[text()='Comprar bombillas LED']]") do
      click_on "Eliminar tarea"
    end
    assert_no_text "Comprar bombillas LED"
  end

  test "creates and deletes a list from the dialog" do
    find("button[aria-label='Nueva lista']").click
    within "dialog[open]" do
      fill_in "Nombre", with: "Vacaciones"
      click_on "Crear lista"
    end
    assert_selector "h1", text: "Vacaciones"
    assert_selector "#sidebar", text: "Vacaciones"

    accept_confirm { find("button[aria-label='Eliminar lista']").click }
    assert_selector "h1", text: /Buenas/
    assert_no_selector "#sidebar", text: "Vacaciones"
  end

  test "users only see their own lists" do
    assert_selector "#sidebar", text: "Casa"
    assert_no_selector "#sidebar", text: "Lista de Bob"
  end
end
