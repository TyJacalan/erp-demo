# frozen_string_literal: true

class AlertsController < ApplicationController
  def index
    @notifications = current_user.notifications.includes(:event)
    @count = @notifications.count
    authorize @notifications
  end
end
