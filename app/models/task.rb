# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :client

  validates :description, :department, :category, :hours, presence: true
  validates :hours, numericality: { greater_than_or_equal_to: 0 }

  enum department: { research: 0, writing: 1, editorial: 2, account_management: 3, accounting: 4, business_development: 5, design: 6, social_media: 7, others: 8 } 
end
