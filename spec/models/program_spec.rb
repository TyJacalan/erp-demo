# frozen_string_literal: true

# == Schema Information
#
# Table name: programs
#
#  id              :bigint           not null, primary key
#  current_funding :integer          default(0)
#  description     :text
#  issue_areas     :text             default([]), is an Array
#  name            :string           not null
#  target_funding  :integer          default(0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#
# Indexes
#
#  index_programs_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
require 'rails_helper'

RSpec.describe Program, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
