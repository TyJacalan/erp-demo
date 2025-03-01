# frozen_string_literal: true

class ClientNotifier < ApplicationNotifier
  notification_methods do
    def message
      params[:message]
    end
  end
end
