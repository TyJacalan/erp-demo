# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters

    def edit
      @user = User.new
      @user.build_location
      super
    end

    def create
      @user = User.new(user_params)
      super
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[password mobile birthdate location_attributes])
      devise_parameter_sanitizer.permit(:invite, keys: %i[full_name email position salary])
    end

    private

    def user_params
      params.require(:user).permit(:email, :full_name, :team, :position, :salary,
                                   location_attributes: %i[street city country])
    end
  end
end
