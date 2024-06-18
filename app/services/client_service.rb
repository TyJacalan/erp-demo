# frozen_string_literal: true

class ClientService
  def initialize(client_params, user)
    @client_params = client_params
    @user = user
  end

  def create
    ActiveRecord::Base.transaction do
      @client = Client.new(@client_params)
      @client.issue_areas = @client_params[:issue_areas].split(',').map(&:strip)

      @client.save

      message = "#{@user.full_name} created a new client."
      notify_managers(message)
    end

    @client
  end

  private

  def notify_managers(message)
    client_managers = User.where(client_manager: true).where.not(id: @user.id)
    ClientNotifier.with(record: @client, message:).deliver_later(client_managers)

    client_managers.each do |client_manager|
      Turbo::StreamsChannel.broadcast_replace_to(
        "alerts_#{client_manager.id}",
        target: "alerts_#{client_manager.id}",
        partial: 'alerts/alert',
        locals: { count: client_manager.notifications.count,
                  notifications: client_manager.notifications }
      )
    end
  end
end
