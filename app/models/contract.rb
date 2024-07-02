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
class Contract < ApplicationRecord
  belongs_to :client

  validates :monthly_fee, :start_date, :service_type, presence: true

  enum service_type: { research: 0, writing: 1, research_writing: 2, accounting: 3, complete: 4 }
end
