# frozen_string_literal: true

class TaskCategory < ApplicationRecord
  has_many :tasks

  validates :department, :name, presence: true
  validates :name, uniqueness: true

  enum department: { research: 0, writing: 1, editorial: 2, account_management: 3, accounting: 4,
                     business_development: 5, design: 6, social_media: 7, others: 8 }
end
