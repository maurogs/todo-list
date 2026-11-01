class TasksController < ApplicationController
  before_action :set_list, only: :create
  before_action :set_task, only: %i[ edit update destroy toggle ]

  def create
    task = @list.tasks.build(task_params)

    if task.save
      back_or_to @list
    else
      back_or_to @list, alert: "No se pudo crear la tarea: #{task.errors.full_messages.to_sentence}"
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      back_or_to @task.list
    else
      back_or_to @task.list, alert: "No se pudo guardar: #{@task.errors.full_messages.to_sentence}"
    end
  end

  def toggle
    @task.toggle!
    back_or_to @task.list
  end

  def destroy
    @task.destroy
    back_or_to @task.list
  end

  def sort
    Sortable.apply(Task.where(list: current_user.lists), params[:ids])
    head :no_content
  end

  private
    def set_list
      @list = current_user.lists.find(params[:list_id])
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def task_params
      params.expect(task: %i[ title notes due_on priority ])
    end
end
