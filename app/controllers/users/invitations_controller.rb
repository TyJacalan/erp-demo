# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[password mobile birthdate])
      devise_parameter_sanitizer.permit(:invite, keys: %i[full_name email position salary])
    end
  end
end
