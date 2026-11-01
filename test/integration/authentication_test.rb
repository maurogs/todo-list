require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  test "redirects anonymous visitors to the sign in page" do
    get root_path
    assert_redirected_to new_session_path

    get list_path(lists(:home))
    assert_redirected_to new_session_path
  end

  test "signs in with valid credentials" do
    sign_in_as users(:alice)
    assert_redirected_to root_path

    follow_redirect!
    assert_response :success
    assert_select "h1", /Alice/
  end

  test "rejects invalid credentials" do
    post session_path, params: { email_address: "alice@example.com", password: "wrong" }
    assert_redirected_to new_session_path
    assert_equal "Email o contraseña incorrectos.", flash[:alert]
  end

  test "signs out" do
    sign_in_as users(:alice)
    delete session_path
    assert_redirected_to new_session_path

    get root_path
    assert_redirected_to new_session_path
  end

  test "registers a new user with a starter list" do
    assert_difference [ "User.count", "List.count" ], 1 do
      post registration_path, params: { user: { name: "Eva", email_address: "eva@example.com", password: "password123", password_confirmation: "password123" } }
    end
    assert_redirected_to root_path

    follow_redirect!
    assert_response :success
    assert_select "#sidebar", /Mi primera lista/
  end

  test "shows errors when registration is invalid" do
    assert_no_difference "User.count" do
      post registration_path, params: { user: { name: "Eva", email_address: "eva@example.com", password: "password123", password_confirmation: "nope" } }
    end
    assert_response :unprocessable_entity
  end

  test "the sign in and registration pages render" do
    get new_session_path
    assert_response :success
    get new_registration_path
    assert_response :success
  end
end
