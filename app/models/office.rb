# frozen_string_literal: true

class Office < ApplicationRecord
  belongs_to :organization
  belongs_to :location
end
