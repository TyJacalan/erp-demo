class Office < ApplicationRecord
  belongs_to :organization
  belongs_to :location
end
