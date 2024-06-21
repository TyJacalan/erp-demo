# frozen_string_literal: true

class WorkplanController < ApplicationController
  skip_after_action :verify_authorized
  add_breadcrumb 'Workplan', :workplan_index_path

  def index; end
end
