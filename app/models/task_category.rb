# frozen_string_literal: true

# == Schema Information
#
# Table name: task_categories
#
#  id         :bigint           not null, primary key
#  department :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class TaskCategory < ApplicationRecord
  has_many :tasks

  validates :department, :name, presence: true
  validates :name, uniqueness: true

  enum department: { research: 0, writing: 1, editorial: 2, account_management: 3, accounting: 4,
                     business_development: 5, design: 6, social_media: 7, others: 8 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[department name]
  end
end
