# frozen_string_literal: true

class Contract < ApplicationRecord
  belongs_to :client

  validates :monthly_fee, :start_date, :service_type, presence: true

  enum service_type: { research: 0, writing: 1, research_writing: 2, accounting: 3, complete: 4 }
end
