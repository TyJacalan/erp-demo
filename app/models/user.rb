# frozen_string_literal: true

class User < ApplicationRecord
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :full_name, :email, :position, presence: true

  enum position: {
    development_associate: 0,
    senior_development_associate: 1,
    writer: 2,
    senior_writer: 3,
    freelancer: 4,
    associate_development_manager: 5,
    development_manager: 6
  }
end
