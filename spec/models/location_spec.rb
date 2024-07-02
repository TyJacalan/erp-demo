# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  address    :string
#  city       :string
#  country    :string
#  latitude   :string
#  longitude  :string
#  state      :string
#  street     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'geocoding' do
    let(:location) { Location.new(city: 'Manila', country: 'Philippines') }

    it 'geocodes address after validation if address is present and changed' do
      expect(location).to receive(:geocode)
      location.valid?
    end

    it 'does not geocode if address is not present' do
      location.city = nil
      location.country = nil
      expect(location).not_to receive(:geocode)
      location.valid?
    end

    it 'does not geocode if address has not changed' do
      allow(location).to receive(:address_changed?).and_return(false)
      expect(location).not_to receive(:geocode)
      location.valid?
    end
  end

  describe '#address' do
    it 'returns a formatted address' do
      location = Location.new(street: '123 Main St', city: 'Manila', state: 'MNL', country: 'Philippines')
      expect(location.address).to eq('123 Main St, Manila, MNL, Philippines')
    end
  end

  describe '#address_changed?' do
    let(:location) { Location.new(street: '123 Main St', city: 'Manila', country: 'Philippines') }

    it 'returns true if any address components have changed' do
      allow(location).to receive(:street_changed?).and_return(true)
      expect(location.address_changed?).to be(true)
    end

    it 'returns false if no address components have changed' do
      allow(location).to receive(:street_changed?).and_return(false)
      allow(location).to receive(:city_changed?).and_return(false)
      allow(location).to receive(:state_changed?).and_return(false)
      allow(location).to receive(:country_changed?).and_return(false)
      expect(location.address_changed?).to be(false)
    end
  end
end
