# frozen_string_literal: true

class ClientsController < ApplicationController
  add_breadcrumb 'Clients', :clients_path

  def index; end
end
