# frozen_string_literal: true

# == Schema Information
#
# Table name: memberships
#
#  id              :bigint           not null, primary key
#  memberable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  memberable_id   :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_memberships_on_memberable  (memberable_type,memberable_id)
#  index_memberships_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Membership, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
