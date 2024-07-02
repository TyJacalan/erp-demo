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
require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:valid_task) { tasks(:valid_task) }
  let(:invalid_task) { tasks(:invalid_task) }

  describe 'creating a task' do
    it 'creates a task successfully' do
      valid_task.save

      expect(valid_task).to be_valid
    end

    it 'fails to create an invalid task' do
      invalid_task.save

      expect(invalid_task).not_to be_valid
    end
  end
end
