# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Alerts', type: :request do
  let(:user) { users(:valid_user) }

  context 'when the user is not signed in' do
    describe 'GET /index' do
      it 'redirects to the authentication page' do
        get alerts_path
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  context 'when the user is signed in' do
    before do
      sign_in user
    end

    describe 'GET /index' do
      it 'renders the users notifications' do
        get alerts_path
        expect(response).to have_http_status(:success)
        expect(response.body).to(include('No notifications to display'))
      end
    end
  end
end
