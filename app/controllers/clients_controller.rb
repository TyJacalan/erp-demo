# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[show update destroy]
  before_action :initialize_client_service, only: %i[create]
  add_breadcrumb 'Clients', :clients_path

  def index
    @q = Client.ransack(params[:q])
    @pagy, @clients = pagy(@q.result.includes(:logo_attachment))
    @client = Client.new
    authorize @clients
  end

  def show; end

  def create
    @client = @client_service.create
    authorize @client
    message = "#{current_user.full_name} #{t "client.#{action_name}.success"} #{@client.name}"
    handle_turbo_response(@client.persisted?, @client, message)
  end

  def update
    message = "#{t "client.#{action_name}.success"} #{@client.name}."
    handle_turbo_response(@client.update(client_params), @client, message)
  end

  def destroy
    message = "#{current_user.full_name} #{t "client.#{action_name}.success"} #{@client.name}"

    if @client.destroy
      flash[:notice] = message
      redirect_to clients_path
    else
      flash[:alert] = @client.error.full_messages.first
      redirect_to client_path(@client)
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :abbreviation, :mission, :logo, :website, :nonprofit_status, :status,
                                   :issue_areas)
  end

  def initialize_client_service
    @client_service = ClientService.new(client_params, current_user)
  end

  def set_client
    @client = Client.find(params[:id])
    authorize @client
  end
end
