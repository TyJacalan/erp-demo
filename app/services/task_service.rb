# frozen_string_literal: true

class TaskService
  attr_reader :tasks, :response

  def create(tasks)
    @tasks = tasks
    validate_tasks
    @response ? save_tasks : false
  end

  private

  def validate_tasks
    @tasks.each(&:valid?)
    @response = @tasks.all?(&:valid?)
  end

  def save_tasks
    Task.insert_all(@tasks.map(&:attributes).map { |attr| attr.except('id', 'created_at', 'updated_at') })
  end
end
