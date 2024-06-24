# frozen_string_literal: true

class ProfileController < ApplicationController
  add_breadcrumb 'Profile', :profile_index_path

  def index
    authorize :profile
  end
end
