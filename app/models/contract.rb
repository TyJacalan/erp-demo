# frozen_string_literal: true

class Contract < ApplicationRecord
  belongs_to :client

  validates :monthly_fee, :start_date, :engagement_type, presence: true
end
