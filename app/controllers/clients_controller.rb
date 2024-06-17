# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[update destroy]
  before_action :initialize_client_service, only: %i[create]
  add_breadcrumb 'Clients', :clients_path

  def index
    @client = Client.new
    @clients = Client.all
  end

  def create
    @client = @client_service.create
    handle_response(@client.persisted?, @client)
  end

  def update
    handle_response(@client.update(client_params), @client)
  end

  def destroy
    handle_response(@client.destroy, @client)
  end

  private

  def client_params
    params.require(:client).permit(:name, :abbreviation, :mission, :logo)
  end

  def initialize_client_service
    @client_service = ClientService.new(client_params, current_user)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end