class ProspectsController < ApplicationController
  before_action :set_organization
  before_action :build_prospect, only: [:create]
  before_action :set_prospect, only: %i[show update destroy]

  def index
    @prospects = Prospect.all
    authorize @prospects
  end

  def show
    @prospect = @organization.prospect || @organization.build_prospect
  end

  def create
    if @prospect.save
      flash.now[:notice] = "#{t "prospect.#{action_name}.success"} #{@organization.name}."
    else
      flash.now[:alert] = t("prospect.#{action_name}.failure")
    end
  end

  def update
    if @prospect.update(prospect_params)
      redirect_to organization_path(@organization), notice: 'success'
    else
      redirect_to organization_path(@organization), alert: 'failure'
    end
  end

  def destroy
    @prospect.destroy
    redirect_to organization_path(@organization), notice: 'success'
  end

  private

  def set_organization
    @organization = Organization.find(params[:organization_id])
    authorize @organization
  end

  def set_prospect
    @prospect = @organization.prospect
    authorize @prospect
  end

  def build_prospect
    @prospect = @organization.prospect || @organization.build_prospect(prospect_params)
    @prospect.created_by = current_user
    @prospect.updated_by = current_user
  end

  def prospect_params
    params.require(:prospect).permit(:founder, :founding_year, :instagram, :history, :linkedin, :youtube, :vision)
  end
end

