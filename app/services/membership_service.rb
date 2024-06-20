# frozen_string_literal: true

class MembershipService
  def initialize(user, memberable)
    @user = user
    @memberable = memberable
  end

  def create(membership)
    ActiveRecord::Base.transaction do
      @membership = membership
      @membership.save

      message = "#{@user.full_name} added #{@membership.user.full_name} to the #{@memberable.name} team."
      notify_team_members(message)
    end

    @membership
  end

  def destroy(membership)
    ActiveRecord::Base.transaction do
      @membership = membership
      @membership.destroy

      message = "#{@user.full_name} removed #{@membership.user.full_name} from the #{@memberable.name} team."
      notify_team_members(message)
    end

    @membership
  end

  private

  def notify_team_members(message)
    team_members = @memberable.users.includes(:notifications).where.not(id: @user.id)
    MembershipNotifier.with(record: @membership, message:).deliver_later(team_members)

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
