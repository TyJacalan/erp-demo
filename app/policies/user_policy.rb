# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user
  end
end
