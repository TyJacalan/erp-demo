# frozen_string_literal: true

class TeamNotifier < ApplicationNotifier
  notification_methods do
    def message
      params[:message]
    end
  end
end
