# frozen_string_literal: true

class Admin < ApplicationRecord
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable
end
