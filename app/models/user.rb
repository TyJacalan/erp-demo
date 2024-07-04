# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  birthdate              :date
#  client_manager         :boolean          default(FALSE)
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  full_name              :string           default(""), not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  mobile                 :string
#  moderator              :boolean          default(FALSE)
#  position               :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  salary                 :float
#  sign_in_count          :integer          default(0), not null
#  task_manager           :boolean          default(FALSE)
#  team                   :string
#  team_manager           :boolean          default(FALSE)
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#  location_id            :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_location_id           (location_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
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
  has_many :created_prospects, class_name: 'Prospect', foreign_key: 'created_by_id'
  has_many :updated_prospects, class_name: 'Prospect', foreign_key: 'updated_by_id'

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #:omniauthable, omniauth_providers: [:google_oauth2]

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
