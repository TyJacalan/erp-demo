# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProfileController, type: :request do
  let(:user) { users(:valid_user) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    it 'authorizes the profile and renders the index template' do
      get profile_index_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include(user.full_name)
    end

    it 'redirects to sign in page if user is not signed in' do
      sign_out user
      get profile_index_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
