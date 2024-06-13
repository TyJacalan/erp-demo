# frozen_string_literal: true

class User < ApplicationRecord
  include RoleAssignable

  has_one_attached :avatar

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validates :full_name, :email, :position, presence: true
  validates :full_name, :email, uniqueness: true

  def self.distinct_positions
    pluck(:position).uniq.compact.sort
  end

  def self.distinct_teams
    pluck(:team).uniq.compact.sort
  end
end
