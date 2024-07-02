# frozen_string_literal: true

# == Schema Information
#
# Table name: offices
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  location_id     :bigint           not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_offices_on_location_id      (location_id)
#  index_offices_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#  fk_rails_...  (organization_id => organizations.id)
#
class Office < ApplicationRecord
  belongs_to :organization
  belongs_to :location
end
