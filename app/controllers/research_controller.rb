# frozen_string_literal: true

class ResearchController < ApplicationController
  skip_after_action :verify_authorized
  add_breadcrumb 'Research', :research_index_path

  def index; end
end
