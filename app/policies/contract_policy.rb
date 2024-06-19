# frozen_string_literal: true

class ContractPolicy < ApplicationPolicy
  def index?
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
