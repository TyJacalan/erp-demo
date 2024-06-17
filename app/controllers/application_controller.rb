# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  add_breadcrumb 'Home', :root_path

  protected

  def authenticate_inviter!
    authenticate_admin!(force: true)
  end

  def handle_response(response, obj)
    respond_to do |format|
      if response
        flash.now[:notice] = t "client.#{action_name}.success"
        format.turbo_stream
      else
        flash.now[:alert] = @obj.errors.first.full_messages if obj.present?
        format.turbo_stream
      end
    end
  end
end
