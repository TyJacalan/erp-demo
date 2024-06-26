# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:user) { users(:valid_user) }
  let(:task_manager) { users(:task_manager) }
  let(:client) { clients(:valid_client) }
  let(:task_category) { task_categories(:valid_category) }
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
        expect(response).to have_http_status(:not_acceptable)
      end
    end

    describe 'PATCH /update' do
      it 'restricts access' do
        patch task_path(task), params: { task: { name: 'Updated Task' } }
        expect(response).to have_http_status(:not_acceptable)
      end
    end

    describe 'DELETE /destroy' do
      it 'restricts access' do
        delete task_path(task)
        expect(response).to have_http_status(:not_acceptable)
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

    describe 'POST /create' do
      let(:task_params) do
        {
          client_id: client.id,
          tasks: {
            '0' => {
              name: 'New Task',
              hours: 5,
              deadline: 1.week.from_now.strftime('%Y-%m-%d'),
              task_category_id: task_category.id,
              user_id: task_manager.id
            }
          }
        }
      end

      it 'creates a new task and responds with a success toast' do
        post tasks_path, params: task_params, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
        expect(flash[:notice]).to eq(I18n.t('task.create.success'))
      end
    end

    describe 'POST /create' do
      let(:task_params) do
        {
          client_id: client.id,
          tasks: {
            '0' => {
              name: 'New Task',
              hours: 5,
              deadline: 1.week.from_now.strftime('%Y-%m-%d')
            }
          }
        }
      end

      it 'does not create a new task and responds with an error toast' do
        post tasks_path, params: task_params, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
        expect(flash[:alert]).to eq('Submission failed! Errors were found.')
      end
    end

    describe 'PATCH /update' do
      it 'updates the task and returns success' do
        patch task_path(task), params: { task: { name: 'Updated Task' } },
                               headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        task.reload
        expect(task.name).to eq('Updated Task')
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
        expect(flash[:notice]).to eq(I18n.t('task.update.success'))
      end
    end

    describe 'DELETE /destroy' do
      it 'deletes the task and returns success' do
        delete task_path(task), headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
        expect(Task.exists?(task.id)).to be_falsey
        expect(flash[:notice]).to eq(I18n.t('task.destroy.success'))
      end
    end
  end
end
