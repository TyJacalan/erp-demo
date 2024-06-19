# frozen_string_literal: true

class TeamService
  def initialize(team_params, user)
    @team_params = team_params
    @user = user
  end

  def create
    ActiveRecord::Base.transaction do
      @member = Team.new(@team_params)
      @client = Client.find(@team_params[:client_id])
      @new_member = User.find(@team_params[:user_id])

      @member.save

      message = "#{@user.full_name} added #{@new_member.full_name} to the #{@client.name} team."
      notify_team_members(message)
    end

    @member
  end

  private

  def notify_team_members(message)
    team_members = @client.users
    TeamNotifier.with(record: @member, message:).deliver_later(team_members)

    team_members.each do |member|
      Turbo::StreamsChannel.broadcast_replace_to(
        "alerts_#{member.id}",
        target: "alerts_#{member.id}",
        partial: 'alerts/alert',
        locals: { count: member.notifications.count,
                  notifications: member.notifications }
      )
    end
  end
end
