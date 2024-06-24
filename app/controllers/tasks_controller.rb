# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authorize_referer, only: %i[index]
  before_action :load_resources, except: %i[destroy]
  before_action :task, only: %i[update destroy]

  def index
    @q = current_user.tasks.includes(:task_category, client: [:logo_attachment]).ransack(params[:q])
    @pagy, @tasks = pagy(@q.result, items: 10)
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

  def update
    if @task.update(task_params)
      flash.now[:notice] = t("task.#{action_name}.success")
    else
      flash.now[:alert] = @task.errors.full_messages.first
    end
  end

  def destroy
    if @task.destroy
      flash.now[:notice] = t("task.#{action_name}.success")
    else
      flash.now[:alert] = @task.errors.full_messages.first
    end
  end

  private

  def authorize_referer
    unless request.referer&.include?(workplan_index_path)
      redirect_to workplan_index_path
    end
  end

  def build_tasks
    client_id = params[:client_id]

    tasks_params.map do |task_param|
      task = Task.new(task_param.merge(client_id:))
      authorize task
    end
  end

  def load_resources
    @users = User.select(:id, :full_name)
    @clients = Client.select(:id, :abbreviation)
    @categories = TaskCategory.select(:id, :name)
  end

  def task
    @task = Task.find(params[:id])
    authorize @task
  end

  def task_service
    @task_service ||= TaskService.new
  end

  def task_params
    params.require(:task).permit(:name, :status, :hours, :deadline, :user_id, :client_id)
  end

  def tasks_params
    params.require(:tasks).permit!.to_h.values
  end
end
