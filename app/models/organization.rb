# frozen_string_literal: true

class Organization < ApplicationRecord
  belongs_to :headquarter, class_name: 'Location', optional: true, foreign_key: :location_id
  has_many :offices
  has_many :locations, through: :offices
  has_one_attached :logo
  has_one :prospect

  validates :name, presence: true, uniqueness: true
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, allow_blank: true

  accepts_nested_attributes_for :headquarter
  accepts_nested_attributes_for :offices, allow_destroy: true

  after_save { Rails.cache.delete_matched(/^pagy-#{self.class.name}:/) }

  enum organization_type: { nonprofit: 0, for_profit: 1, government: 2, education: 3 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name organization_type]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[headquarter locations]
  end
end
