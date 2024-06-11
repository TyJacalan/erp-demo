# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def index; end
end
