# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show update destroy]
  before_action :set_organization, only: [:show]
  before_action :build_client, only: %i[index create]
  before_action :initialize_client_service, only: %i[create]
  add_breadcrumb 'Clients', :clients_path

  def index
    @q = Client.ransack(params[:q])
    @pagy, @clients = pagy(@q.result.includes(:logo_attachment, :organization))
    authorize @clients
  end

  def show
    add_breadcrumb @client.abbreviation, client_path(@client)
  end

  def create
    @client = @client_service.create
    authorize @client

    if @client.persisted?
      flash.now[:notice] = "#{current_user.full_name} #{t "client.#{action_name}.success"} #{@client.abbreviation}"
    else
      flash.now[:alert] = @client.errors.full_messages.first
    end
  end

  def update
    if @client.update(client_params)
      flash.now[:notice] = "#{t "client.#{action_name}.success"} #{@client.abbreviation}."
    else
      flash.now[:alert] = @client.errors.full_messages
    end
  end

  def destroy
    if @client.destroy
      flash[:notice] = "#{current_user.full_name} #{t "client.#{action_name}.success"} #{@client.abbreviation}"
      redirect_to clients_path
    else
      flash[:alert] = @client.error.full_messages.first
      redirect_to client_path(@client)
    end
  end

  private

  def build_client
    @new_client = Client.new
    @new_client.build_organization
  end

  def client_params
    params.require(:client).permit(:abbreviation, :logo, :status, :issue_areas,
                                   organization_attributes: %i[name mission website organization_type location_id])
  end

  def initialize_client_service
    @client_service = ClientService.new(client_params, current_user)
  end

  def set_client
    @client = Client.find(params[:id])
    authorize @client
  end

  def set_organization
    @organization = Organization.find(@client.organization.id)
    authorize @organization
  end
end
