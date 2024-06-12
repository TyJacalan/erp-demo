# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar

  devise :invitable, :database_authenticatable, :registerable,
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

  def avatar_thumbnail
    avatar.variant(resize: '150x150!')
  end
end
