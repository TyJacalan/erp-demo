# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_resources, only: %i[new create]

  def index
    @tasks = current_user.tasks
    authorize @tasks
  end

  def new
    @tasks = Array.new(2) { Task.new }
    authorize @tasks.first
  end

  def create
    client_id = params[:client_id]

    @tasks = task_params.map do |task_param|
      task = Task.new(task_param.merge(client_id:))
      authorize task
    end

    all_valid = @tasks.all?(&:valid?)

    if all_valid
      Task.insert_all(@tasks.map(&:attributes).map { |attr| attr.except('id', 'created_at', 'updated_at') })
      redirect_to workplan_index_path, notice: t("task.#{action_name}.success")
    else
      flash.now[:alert] = 'Errors'
    end
  end

  def update; end

  def destroy; end

  private

  def load_resources
    @users = User.select(:id, :full_name)
    @clients = Client.select(:id, :abbreviation)
    @categories = TaskCategory.select(:id, :name)
  end

  def task_params
    params.require(:tasks).permit!.to_h.values
  end
end
