# frozen_string_literal: true

class User < ApplicationRecord
  include RoleAssignable
  include Turbo::Broadcastable

  has_one_attached :avatar
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: 'Noticed::Notification'
  has_many :mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'
  has_many :teams
  has_many :clients, through: :teams

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
