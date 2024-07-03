# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Clients', type: :request do
  let(:user) { users(:valid_user) }
  let(:client_manager) { users(:client_manager) }
  let(:client) { clients(:valid_client) }
  let(:organization) { organizations(:valid_organization) }

  context 'when the user is a non-task manager' do
    before do
      sign_in user
    end

    describe 'GET /index' do
      it 'renders the index template' do
        get clients_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(client.organization.name)
      end

      it 'does not render the add new client button' do
        get clients_path
        expect(response.body).not_to include('Add a new client')
      end
    end

    describe 'GET /show' do
      it 'renders the show template' do
        get client_path(client)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(client.abbreviation)
      end

      it 'does not render the client update and delete buttons' do
        get client_path(client)
        expect(response.body).not_to include("Edit #{client.abbreviation}")
        expect(response.body).not_to include("Delete #{client.abbreviation}")
      end
    end

    describe 'PATCH /update' do
      let(:update_params) do
        {
          client: {
            abbreviation: 'UC',
            status: 'inactive',
            organization:
          }
        }
      end
    end
  end

  context 'when the user is a client manager' do
    before do
      sign_in client_manager
    end

    describe 'GET /index' do
      it 'renders the index template' do
        get clients_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(client.organization.name)
        expect(response.body).to include('Add a new client')
      end
    end

    describe 'GET /show' do
      it 'renders the client update and delete buttons' do
        get client_path(client)
        expect(response.body).to include("Edit #{client.abbreviation}")
        expect(response.body).to include("Delete #{client.abbreviation}")
      end
    end

    describe 'POST /create' do
      let(:client_params) do
        {
          client: {
            abbreviation: 'NC',
            status: 'pending',
            issue_areas: 'Health',
            organization_attributes: {
              name: 'New Client',
              mission: 'Mission description',
              website: 'https://www.example.com',
              organization_type: :nonprofit
            }
          }
        }
      end

      it 'creates a new client' do
        expect do
          post clients_path, params: client_params, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        end.to change(Client, :count).by(1)

        expect(response.body).to include('New Client')
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
        expect(flash[:notice]).to eq("#{client_manager.full_name} created a new client: NC")
      end
    end

    describe 'PATCH /update' do
      let(:update_params) do
        {
          client: {
            abbreviation: 'UC',
            status: 'inactive',
            organization:
          }
        }
      end

      it 'updates the client' do
        patch client_path(client), params: update_params, headers: { 'Accept' => 'text/vnd.turbo-stream.html' }
        client.reload
        expect(client.abbreviation).to eq('UC')
        expect(response.content_type).to include('text/vnd.turbo-stream.html')
        expect(flash[:notice]).to eq("#{I18n.t('client.update.success')} #{client.abbreviation}.")
      end
    end

    describe 'DELETE /destroy' do
      it 'deletes the client' do
        expect do
          delete client_path(client)
        end.to change(Client, :count).by(-1)
        expect(response).to redirect_to(clients_path)
        follow_redirect!
        expect(flash[:notice]).to eq("#{client_manager.full_name} deleted a client: #{client.abbreviation}")
      end
    end
  end
end
