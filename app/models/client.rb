# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id              :bigint           not null, primary key
#  abbreviation    :string
#  issue_areas     :text             default([]), is an Array
#  status          :integer          default("pending"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  location_id     :bigint
#  organization_id :bigint           not null
#
# Indexes
#
#  index_clients_on_location_id      (location_id)
#  index_clients_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (organization_id => organizations.id)
#
class Client < ApplicationRecord
  belongs_to :organization
  has_one_attached :logo
  has_many :contracts
  has_many :mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'
  has_many :memberships, as: :memberable
  has_many :tasks, dependent: :destroy
  has_many :users, through: :memberships

  accepts_nested_attributes_for :organization

  validates :abbreviation, presence: true
  validates :abbreviation, uniqueness: true

  after_save { Rails.cache.delete_matched(/^pagy-#{self.class.name}:/) }

  enum status: { pending: 0, onboarding: 1, active: 2, inactive: 3 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name abbreviation issue_areas]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user]
  end

  ransacker :issue_areas do
    Arel.sql("array_to_string(issue_areas, ',')")
  end
end
