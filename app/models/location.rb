class Location < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address.present? and obj.address_changed? }

  validates :city, :country, presence: true

  def address
    [street, city, state, country].compact.join(', ')
  end

  def address_changed?
    street_changed? || city_changed? || state_changed? || country_changed?
  end
end
