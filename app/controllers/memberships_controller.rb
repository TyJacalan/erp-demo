# frozen_string_literal: true

class MembershipsController < ApplicationController
  before_action :memberable
  before_action :membership_service, only: %i[create destroy]

  def index
    @memberships = @memberable.memberships.includes(:user)
    authorize @memberships
  end

  def new
    @users = User.all
    @membership = Membership.new
    authorize @membership
  end

  def create
    @membership = Membership.new(memberships_params)
    authorize @membership

    @membership_service.create(@membership)

    message = "You added a new member to the #{@memberable.name} team."
    handle_turbo_response(@membership.persisted?, @membership, message)
  end

  def destroy
    @membership = Membership.find(params[:id])
    authorize @membership

    @membership_service.destroy(@membership)

    message = "You removed #{@membership.user.full_name} from #{@memberable.name}."
    handle_turbo_response(@membership.persisted?, @membership, message)
  end

  private

  def memberable
    return unless params[:client_id].present?

    @memberable ||= Client.find(params[:client_id])
  end

  def memberships_params
    params.require(:membership).permit(:memberable_id, :user_id, :memberable_type)
  end

  def membership_service
    @membership_service ||= MembershipService.new(current_user, memberable)
  end
end
