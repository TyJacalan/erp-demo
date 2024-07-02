# frozen_string_literal: true

# == Schema Information
#
# Table name: contracts
#
#  id           :bigint           not null, primary key
#  end_date     :date
#  monthly_fee  :float
#  service_type :integer
#  start_date   :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  client_id    :bigint           not null
#
# Indexes
#
#  index_contracts_on_client_id  (client_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#
require 'rails_helper'

RSpec.describe Contract, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
