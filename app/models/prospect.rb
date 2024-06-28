# frozen_string_literal: true

class Prospect < ApplicationRecord
  belongs_to :organization
  belongs_to :created_by, class_name: 'User'
  belongs_to :updated_by, class_name: 'User'
end
