# frozen_string_literal: true

class ClientsController < ApplicationController
  add_breadcrumb 'Clients', :clients_path

  def index
    @client = Client.new
  end

  private

  def client_params
    params.require(:client).permit(:name, :abbreviation, :mission)
  end
end