# frozen_string_literal: true

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
