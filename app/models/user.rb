# frozen_string_literal: true

class User < ApplicationRecord
  include RoleAssignable
  include Turbo::Broadcastable

  belongs_to :location, optional: true
  has_one_attached :avatar
  has_many :clients, through: :memberships, source: :memberable, source_type: 'Client'
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: 'Noticed::Notification'
  has_many :mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'
  has_many :memberships
  has_many :tasks

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  accepts_nested_attributes_for :location
  validates :full_name, :email, :position, presence: true
  validates :full_name, :email, uniqueness: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[full_name email position]
  end

  def self.distinct_positions
    pluck(:position).uniq.compact.sort
  end

  def self.distinct_teams
    pluck(:team).uniq.compact.sort
  end
end
