require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "normalizes the email address" do
    user = User.new(name: " Eva ", email_address: "  EVA@Example.COM ", password: "password123")
    assert_equal "eva@example.com", user.email_address
    assert_equal "Eva", user.name
    assert user.valid?
  end

  test "requires a unique email address" do
    user = User.new(name: "Otra", email_address: users(:alice).email_address, password: "password123")
    assert_not user.valid?
    assert user.errors.of_kind?(:email_address, :taken) || user.errors[:email_address].any?
  end

  test "requires a password of at least 8 characters" do
    user = User.new(name: "Eva", email_address: "eva@example.com", password: "short")
    assert_not user.valid?
    assert_includes user.errors.attribute_names, :password
  end

  test "destroying a user removes its lists and tasks" do
    assert_difference({ "List.count" => -2, "Task.count" => -5 }) do
      users(:alice).destroy
    end
  end
end
