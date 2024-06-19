class TeamPolicy < ApplicationPolicy
  def index?
    user
  end

  def new?
    user.client_manager?
  end

  def create?
    user.client_manager?
  end

  def destroy?
    user.client_manager?
  end
end
