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
require 'rails_helper'

RSpec.describe Client, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
