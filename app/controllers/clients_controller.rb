# frozen_string_literal: true

class ClientsController < ApplicationController
  add_breadcrumb 'Clients', :clients_path

  def index
    @client = Client.new
    @clients = Client.all
  end

  def create
    @client = Client.new(client_params)
    handle_response(@client.save, @client)
  end

  def update
    @client = Client.find(params[:id])
    handle_response(@client.update(client_params), @client)
  end

  def destroy
    @client = Client.find(params[:id])

    handle_response(@client.destroy, @client)
  end

  private

  def client_params
    params.require(:client).permit(:name, :abbreviation, :mission, :logo)
  end

  def handle_response(response, obj)
    respond_to do |format|
      if response
        flash.now[:notice] = t "client.#{action_name}.success"
        format.turbo_stream
      else
        flash.now[:alert] = @obj.errors.first.full_messages if obj.present?
        format.turbo_stream
      end
    end
  end
end