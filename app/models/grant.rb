# frozen_string_literal: true

# == Schema Information
#
# Table name: grants
#
#  id              :bigint           not null, primary key
#  amount          :integer          default(0)
#  description     :text
#  duration        :integer
#  grant_type      :integer          default("undisclosed_type")
#  purpose         :integer          default("undisclosed_purpose"), not null
#  recipient       :text             not null
#  year            :string           default("Undisclosed")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organization_id :bigint           not null
#  program_id      :bigint
#  recipient_id    :bigint
#
# Indexes
#
#  index_grants_on_organization_id  (organization_id)
#  index_grants_on_program_id       (program_id)
#  index_grants_on_recipient_id     (recipient_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#  fk_rails_...  (program_id => programs.id)
#  fk_rails_...  (recipient_id => organizations.id)
#
class Grant < ApplicationRecord
  belongs_to :organization
  belongs_to :recipient_organization
  belongs_to :program, optional: true

  enum purpose: { undisclosed_purpose: 0, project: 1, program: 2, unrestricted: 3 }
  enum grant_type: { undisclosed_type: 0, one_time: 1, multi_year: 2 }

  validates :recipient, presence: true
  validates :amount, :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
