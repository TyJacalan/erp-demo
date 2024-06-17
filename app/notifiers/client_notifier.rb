# frozen_string_literal: true

# To deliver this notification:
#
# ClientNotifier.with(record: @post, message: "New post").deliver(User.all)

class ClientNotifier < ApplicationNotifier
  notification_methods do
    def message
      params[:message]
    end
  end
end
