class AlertsController < ApplicationController
    def index
        @notifications = current_user.notifications
        @count = current_user.notifications.count
    end
end