class HomeController < ApplicationController
  def show
    tasks = current_user.tasks.includes(:list)

    @overdue = tasks.pending.where(due_on: ...Date.current).order(:due_on, :position)
    @today = tasks.pending.where(due_on: Date.current).order(:position)
    @upcoming = tasks.pending.where(due_on: Date.tomorrow..7.days.from_now.to_date).order(:due_on, :position)
    @pending_count = tasks.pending.count
    @completed_this_week = tasks.completed.where(completed_at: Time.current.beginning_of_week..).count
  end
end
