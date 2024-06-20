# frozen_string_literal: true

class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :memberable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[memberable_id memberable_type], message: 'is already a member' }
end
