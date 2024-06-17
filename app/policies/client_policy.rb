# frozen_string_literal: true

class ClientPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user
  end

  def create?
    user.client_manager?
  end

  def update?
    user.client_manager?
  end

  def destroy?
    user.client_manager?
  end
end
