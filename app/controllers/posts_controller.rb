# frozen_string_literal: true

class PostsController < ApplicationController
  skip_after_action :verify_authorized

  def index?; end
end
