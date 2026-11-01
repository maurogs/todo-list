require "test_helper"

Capybara.enable_aria_label = true

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1000 ]

  def sign_in_through_the_form(user)
    visit new_session_path
    fill_in "Email", with: user.email_address
    fill_in "Contraseña", with: SignInHelper::PASSWORD
    click_on "Iniciar sesión"
    assert_text "Buenas"
  end
end
