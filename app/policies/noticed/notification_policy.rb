# frozen_string_literal: true

module Noticed
  class NotificationPolicy < ApplicationPolicy
    def index?
      user.present?
    end
  end
end
