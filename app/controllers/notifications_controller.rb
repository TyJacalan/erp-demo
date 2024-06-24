# frozen_string_literal: true

class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.includes(:event).reverse
    authorize @notifications
  end
end
