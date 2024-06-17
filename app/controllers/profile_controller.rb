# frozen_string_literal: true

class ProfileController < ApplicationController
  def index
    authorize :profile
  end
end
