# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations], controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    invitations: 'users/invitations'
  }

  authenticate :admin do
    mount Avo::Engine, at: Avo.configuration.root_path
  end

  authenticated :admin do
    root to: redirect(Avo.configuration.root_path), as: :admin_root
  end

  root 'posts#index'

  # Sidebar
  resources :clients, except: %i[new edit] do
    resources :contracts, except: %i[new edit]
    resources :memberships, except: %i[show edit update], defaults: { memberable_type: 'Client' }
  end

  resources :posts
  resources :research
  resources :workplan, only: %i[index]
  resources :users

  resources :alerts
  resources :notifications
  resources :profile, only: [:index]
  resources :tasks, except: %i[show edit]

  # Error routes
  get '/404', to: 'errors#not_found', via: :all
  get '/403', to: 'errors#forbidden', via: :all
  get '/422', to: 'errors#unprocessable', via: :all
  get '/500', to: 'errors#internal_server_error', via: :all
end
