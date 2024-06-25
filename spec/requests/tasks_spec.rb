# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:user) { users(:valid_user) }
  let(:task_manager) { users(:task_manager)}
  let(:client) { users(:valid_client) }
  let(:task) { tasks(:valid_task) }

  context 'when the user is a non task manager' do
    before do
      sign_in user
    end

    describe 'GET /index' do
      it 'authorizes the user and renders the index template' do
        get workplan_index_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(user.full_name)
      end

      it 'only allows access through the workplan task' do
        get tasks_path
        expect(response).to redirect_to workplan_index_path
      end
    end

    describe 'GET /new' do
      it 'restricts access' do
        get new_task_path
        expect(response).to have_http_status('406')
      end
    end
  end

  context 'when the user is a task manager' do
    before do
      sign_in task_manager
    end

    describe 'GET /new' do
      it 'allows access to the new task path' do
        get new_task_path
        expect(response.body).to include('Create Tasks')
      end
    end
  end
end
