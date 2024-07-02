# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id                :bigint           not null, primary key
#  mission           :text
#  name              :string
#  organization_type :integer          default("nonprofit"), not null
#  website           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  location_id       :bigint           not null
#
# Indexes
#
#  index_organizations_on_location_id  (location_id)
#
# Foreign Keys
#
#  fk_rails_...  (location_id => locations.id)
#
require 'rails_helper'

RSpec.describe Organization, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
