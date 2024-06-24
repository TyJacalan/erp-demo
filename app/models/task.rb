# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :client
  belongs_to :task_category

  validates :name, :hours, :client_id, :user_id, :task_category_id, presence: true
  validates :hours, numericality: { greater_than_or_equal_to: 0 }

  enum status: { pending: 0, active: 1, completed: 2 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user client task_category]
  end
end
