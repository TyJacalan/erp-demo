# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :client
  belongs_to :task_category

  validates :name, :hours, :client_id, :user_id, :task_category_id, presence: true
  validates :hours, numericality: { greater_than_or_equal_to: 0 }
end
