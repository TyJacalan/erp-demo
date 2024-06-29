# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :organizations
  has_many :offices

  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }

  validates :city, :country, presence: true

  def address
    [street, city, state, country].compact.join(', ')
  end

  def address_changed?
    street_changed? || city_changed? || state_changed? || country_changed?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[city country]
  end

  def self.city_and_id
    Location.pluck(:city, :id)
  end
end
