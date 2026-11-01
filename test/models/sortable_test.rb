require "test_helper"

class SortableTest < ActiveSupport::TestCase
  test "applies the given order" do
    ids = [ tasks(:repairs), tasks(:dishes), tasks(:laundry) ].map(&:id)
    Sortable.apply(Task.where(list: lists(:home)), ids)

    assert_equal ids, lists(:home).tasks.pending.pluck(:id)
  end

  test "ignores records outside the scope" do
    Sortable.apply(Task.where(list: lists(:home)), [ tasks(:secret).id ])
    assert_equal 0, tasks(:secret).reload.position
  end
end
