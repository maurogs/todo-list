require "test_helper"

class ListTest < ActiveSupport::TestCase
  test "requires a name" do
    assert_not users(:alice).lists.build(name: "").valid?
  end

  test "rejects unknown colors and icons" do
    assert_not users(:alice).lists.build(name: "X", color: "chartreuse").valid?
    assert_not users(:alice).lists.build(name: "X", icon: "x").valid?
  end

  test "new lists are appended at the end" do
    list = users(:alice).lists.create!(name: "Nueva")
    assert_equal 2, list.position
  end

  test "progress is the percentage of completed tasks" do
    list = lists(:home)
    assert_equal 4, list.total_count
    assert_equal 3, list.pending_count
    assert_equal 25, list.progress
  end

  test "progress is zero for an empty list" do
    assert_equal 0, users(:alice).lists.create!(name: "Vacía").progress
  end
end
