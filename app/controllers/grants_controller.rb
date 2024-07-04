class GrantsController < ApplicationController
  before_action :set_organization
  before_action :set_grant, only: %i[show update destroy]
  before_action :build_grant, only: [:create]

  def index
    @grants = @organization.grants.includes(:recipient) unless @organization.client
    @donations = @organization.donations if @organization.client
  end

  def show; end

  def create
    if @grant.save
      flash.now[:notice] = "#{t "grant.#{action_name}.success" } #{@grant.recipient_name}"
    else
      flash.now[:alert] = @grant.errors.full_messages.first
    end
  end

  def update
    if @grant.update(grant_params)
      flash.now[:notice] = "#{t "grant.#{action_name}.success"} #{@grant.recipient_name}"
    else
      flash.now[:alert] = @grant.errors.full_messages.first
    end
  end

  def destroy
    if @grant.destroy!
      flash.now[:notice] = "#{t "grant.#{action_name}.success"} #{@grant.recipient_name}"
    else
      flash.now[:alert] = @grant.errors.full_messages.first
    end
  end

  private

  def build_grant
    @grant = Grant.new(grant_params)
    @grant.organization_id = @organization.id
    authorize @grant
  end

  def set_organization
    @organization = Organization.includes(:client).find(params[:organization_id])
    authorize @organization
  end

  def set_grant
    @grant = @organization.grants.find(params[:id])
    authorize @grant
  end

  def grant_params
    params.require(:grant).permit(:amount, :description, :duration,
                                  :grant_type, :purpose, :recipient_id,
                                  :recipient_name, :year, :grant_id)
  end
end
