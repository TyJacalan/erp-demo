# frozen_string_literal: true

class UsersController < ApplicationController
  add_breadcrumb 'Users', :users_path

  def index
    @q = User.ransack(params[:q])
    @pagy, @users = pagy(@q.result.includes(:avatar_attachment))
    authorize @users
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end
end
