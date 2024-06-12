# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_params

    protected

    def configure_permitted_params
      devise_parameter_sanitizer.permit(:account_update,
                                        keys: %i[full_name mobile avatar password password_confirmation])
    end
  end
end
