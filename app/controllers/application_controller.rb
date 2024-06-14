# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  add_breadcrumb 'Home', :root_path

  protected

  def authenticate_inviter!
    authenticate_admin!(force: true)
  end
end
