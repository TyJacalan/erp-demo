# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id               :bigint           not null, primary key
#  abbreviation     :string
#  issue_areas      :text             default([]), is an Array
#  mission          :text
#  name             :string
#  nonprofit_status :boolean
#  status           :integer          default("pending"), not null
#  website          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  location_id      :bigint
#
# Indexes
#
#  index_clients_on_location_id  (location_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
class Client < ApplicationRecord
  belongs_to :location, optional: true
  has_one_attached :logo
  has_many :contracts
  has_many :mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'
  has_many :memberships, as: :memberable
  has_many :tasks, dependent: :destroy
  has_many :users, through: :memberships

  accepts_nested_attributes_for :location
  validates :name, :abbreviation, presence: true
  validates :name, :abbreviation, uniqueness: true

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
