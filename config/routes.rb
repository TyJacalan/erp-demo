# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations], controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :users, skip: [:registrations], controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  authenticate :admin do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  authenticated :admin do
    root to: redirect(Avo.configuration.root_path), as: :admin_root
  end

  authenticated :user do
    root to: 'posts#index', as: :user_root
  end

  root 'posts#index'
  resources :posts

  # Error routes
  get '/404', to: 'errors#not_found', via: :all
  get '/403', to: 'errors#forbidden', via: :all
  get '/422', to: 'errors#unprocessable', via: :all
  get '/500', to: 'errors#internal_server_error', via: :all
end
