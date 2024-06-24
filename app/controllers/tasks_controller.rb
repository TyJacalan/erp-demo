# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :load_resources, only: %i[new create]

  def index
    @q = current_user.tasks.ransack(params[:q])
    @pagy, @tasks = pagy(@q.result.includes(:task_category, :client), items: 10)
    authorize @tasks
  end

  def new
    task_count = session[:task_count] || 1
    @tasks = Array.new(task_count) { Task.new }
    authorize @tasks.first
  end

  def create
    @tasks = build_tasks
    if task_service.create(@tasks)
      flash.now[:notice] = t("task.#{action_name}.success")
      @tasks = Array.new(1) { Task.new }
    else
      flash.now[:alert] = t("task.#{action_name}.failure")
    end
  end

  def update; end

  def destroy; end

  private

  def build_tasks
    client_id = params[:client_id]

    task_params.map do |task_param|
      task = Task.new(task_param.merge(client_id:))
      authorize task
    end
  end

  def task_service
    @task_service ||= TaskService.new
  end

  def load_resources
    @users = User.select(:id, :full_name)
    @clients = Client.select(:id, :abbreviation)
    @categories = TaskCategory.select(:id, :name)
  end

  def task_params
    params.require(:tasks).permit!.to_h.values
  end
end
