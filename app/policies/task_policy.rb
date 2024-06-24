# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
  def index?
    user
  end

  def new?
    user.task_manager
  end

  def create?
    user.task_manager
  end

  def update?
    user.task_manager
  end

  def destroy?
    user.task_manager
  end
end
