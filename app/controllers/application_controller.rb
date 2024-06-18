# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit::Authorization
  before_action :authenticate_user!
  after_action :verify_authorized, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  add_breadcrumb 'Home', :root_path

  protected

  def authenticate_inviter!
    authenticate_admin!(force: true)
  end

  def handle_response(response, message = nil)
    respond_to do |format|
      if response
        flash.now[:notice] = message unless message.nil?
      elsif @obj.present?
        flash.now[:alert] = @obj.error.first.full_messages
      end
      format.turbo_stream
    end
  end

  def user_not_authorized
    flash.now[:alert] = t 'policy.unauthorized'
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('toasts', partial: 'components/layout/toast_messages')
      end
    end
  end

  def pagy_get_count(collection, _vars)
    cache_key = "pagy-#{collection.model.name}:#{collection.to_sql}"
    Rails.cache.fetch(cache_key, expires_in: 20 * 60) do
      collection.count(:all)
    end
  end
end
