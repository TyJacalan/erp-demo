class ProgramsController < ApplicationController
  before_action :set_organization
  before_action :set_program, only: %i[show update destroy]
  before_action :build_program, only: [:create]

  def index
    @programs = @organization.programs
  end

  def show; end

  def create
    @program.issue_areas = program_params[:issue_areas].split(',').map(&:strip) if program_params[:issue_areas].present?
    
    if @program.save!
      flash.now[:notice] = "#{t("program.#{action_name}.success")} #{@organization.name}"
    else
      flash.now[:alert] = @program.errors.full_messages.first
    end
  end

  def update
    if @program.update(program_params)
      flash.now[:notice] = "#{t("program.#{action_name}.success")} #{@organization.name}"
    else
      flash.now[:alert] = @program.errors.full_messages.first
    end
  end

  def destroy
    if @program.destroy
      flash.now[:notice] = "#{t("program.#{action_name}.success")} #{@organization.name}"
    else
      flash.now[:alert] = @program.errors.full_messages.first
    end
  end

  private

  def build_program
    @program = Program.new(program_params)
    @program.organization_id = @organization.id
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
    authorize @organization
  end

  def set_program
    @program = @organization.programs.find(params[:id])
    authorize @program
  end

  def program_params
    params.require(:program).permit(:current_funding, :name, :description, :issue_areas, :name, :target_funding)
  end
end
