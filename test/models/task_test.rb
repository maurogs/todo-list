require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "requires a title" do
    assert_not lists(:home).tasks.build(title: " ").valid?
  end

  test "toggle! completes and reopens a task" do
    task = tasks(:dishes)
    assert_not task.completed?

    task.toggle!
    assert task.reload.completed?

    task.toggle!
    assert_not task.reload.completed?
  end

  test "overdue only applies to pending tasks with a past due date" do
    assert tasks(:repairs).overdue?
    assert_not tasks(:laundry).overdue?
    assert_not tasks(:dishes).overdue?

    tasks(:repairs).toggle!
    assert_not tasks(:repairs).overdue?
  end

  test "new tasks are appended at the end of the list" do
    task = lists(:home).tasks.create!(title: "Nueva")
    assert_equal 4, task.position
  end

  test "pending and completed scopes" do
    assert_equal [ tasks(:taxes) ], lists(:home).tasks.completed.to_a
    assert_not_includes lists(:home).tasks.pending, tasks(:taxes)
  end
end
