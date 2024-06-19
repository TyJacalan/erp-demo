# frozen_string_literal: true

class ContractsController < ApplicationController
  def index
    @client = Client.find(params[:client_id])
    @contracts = Contract.where(client_id: @client.id)
    @contract = Contract.new
    authorize @contracts
  end

  def create
    @contract = Contract.new(contract_params)
    authorize @contract

    message = "#{current_user.full_name} created a new contract."
    handle_turbo_response(@contract.save, @contract, message)
  end

  def update; end

  def destroy; end

  private

  def contract_params
    params.require(:contract).permit(:monthly_fee, :start_date, :end_date, :service_type, :client_id)
  end
end
