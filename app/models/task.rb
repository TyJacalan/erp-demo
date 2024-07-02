# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id               :bigint           not null, primary key
#  deadline         :datetime
#  hours            :integer
#  name             :string
#  status           :integer          default("pending")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  client_id        :bigint           not null
#  task_category_id :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_tasks_on_client_id         (client_id)
#  index_tasks_on_task_category_id  (task_category_id)
#  index_tasks_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#  fk_rails_...  (task_category_id => task_categories.id)
#  fk_rails_...  (user_id => users.id)
#
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
