class ListsController < ApplicationController
  before_action :set_list, only: %i[ show update destroy clear_completed ]

  def show
    @pending = @list.tasks.pending
    @completed = @list.tasks.completed.reorder(completed_at: :desc)
  end

  def create
    list = current_user.lists.build(list_params)

    if list.save
      redirect_to list, notice: "Lista creada."
    else
      back_or_to root_path, alert: "No se pudo crear la lista: #{list.errors.full_messages.to_sentence}"
    end
  end

  def update
    if @list.update(list_params)
      back_or_to @list, notice: "Lista actualizada."
    else
      back_or_to @list, alert: "No se pudo guardar: #{@list.errors.full_messages.to_sentence}"
    end
  end

  def destroy
    @list.destroy
    redirect_to root_path, notice: "Lista eliminada.", status: :see_other
  end

  def clear_completed
    @list.tasks.completed.destroy_all
    back_or_to @list, notice: "Tareas completadas eliminadas."
  end

  def sort
    Sortable.apply(current_user.lists, params[:ids])
    head :no_content
  end

  private
    def set_list
      @list = current_user.lists.find(params[:id])
    end

    def list_params
      params.expect(list: %i[ name color icon ])
    end
end
