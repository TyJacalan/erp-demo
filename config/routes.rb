# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations], controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :users, skip: [:registrations], controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  root 'posts#index'
  resources :posts

  # Error routes
  get '/404', to: 'errors#not_found', via: :all
  get '/403', to: 'errors#forbidden', via: :all
  get '/422', to: 'errors#unprocessable', via: :all
  get '/500', to: 'errors#internal_server_error', via: :all
end
