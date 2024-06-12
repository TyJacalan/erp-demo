# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protected

  def authenticate_inviter!
    authenticate_admin!(force: true)
  end
end
