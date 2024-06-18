# frozen_string_literal: true

class Client < ApplicationRecord
  has_one_attached :logo
  has_and_belongs_to_many :users
  has_many :contracts
  has_many :mentions, as: :record, dependent: :destroy, class_name: 'Noticed::Event'

  validates :name, :abbreviation, presence: true
  validates :name, :abbreviation, uniqueness: true

  after_save { Rails.cache.delete_matched(/^pagy-#{self.class.name}:/) }

  enum status: { pending: 0, onboarding: 1, active: 2, inactive: 3 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name abbreviation issue_areas]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[users]
  end

  ransacker :issue_areas do
    Arel.sql("array_to_string(issue_areas, ',')")
  end
end
