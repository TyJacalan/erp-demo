# frozen_string_literal: true

class OrganizationsController < ApplicationController
  before_action :build_organization, only: [:index]
  before_action :set_organization, only: %i[show update destroy]
  before_action :set_resources, only: [:show]
  add_breadcrumb 'Organizations', :organizations_path

  def index
    @q = Organization.ransack(params[:q])
    @pagy, @organizations = pagy(@q.result.includes(:headquarter))
    authorize @organizations
  end

  def show
    add_breadcrumb @organization.name, organization_path(@organization)
  end

  def create
    @organization = Organization.new(organization_params)
    authorize @organization

    if @organization.save!
      flash.now[:notice] = "#{t "organization.#{action_name}.success"} #{@organization.name}"
    else
      flash.now[:alert] = "#{t "organization.#{action_name}.failure"} #{@organization.name}"
    end
  end

  def update
    if @organization.update(organization_params)
      flash.now[:notice] = "#{t "organization.#{action_name}.success"} #{@organization.name}."
    else
      flash.now[:alert] = @organization.errors.full_messages
    end
  end

  def destroy
    if @organization.destroy
      flash[:notice] = "#{t "organization.#{action_name}.success"} #{@organization.name}."
      redirect_to organizations_path
    else
      flash[:alert] = @organization.errors.full_messages
      redirect_to organization_path(@organization)
    end
  end

  private

  def build_organization
    @organization = Organization.new
    @organization.build_headquarter
    3.times { @organization.offices.build }
    @organization.build_prospect
  end

  def set_resources
    @organizations = Organization.pluck(:id, :name)
    @prospect = @organization.prospect || @organization.build_prospect
    @grant = Grant.new
    @program = Program.new
  end

  def set_organization
    @organization = Organization.find(params[:id])
    authorize @organization
  end

  def organization_params
    params.require(:organization).permit(
      :name,
      :website,
      :mission,
      :organization_type,
      :logo,
      headquarter_attributes: %i[id street city state country _destroy],
      offices_attributes: %i[location_id _destroy],
      prospect_attributes: %i[vision founder founding_year history linkedin instagram youtube created_by_id
                              updated_by_id organization_id]
    )
  end
end
