# frozen_string_literal: true

class Admin < ApplicationRecord
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable
end
