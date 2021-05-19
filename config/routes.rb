# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  devise_for :accounts, controllers: { omniauth_callbacks: 'account/omniauth_callbacks' }

  scope '(:locale)', locale: I18n.available_locales.join('|') do
    get '/interests' => 'interests#index', as: :interests_root
  end

  root to: 'public#home'

  resources :dashboard, only: %i[index create]

  resources :messages, only: %i[index create]
  namespace :account do
    resources :profiles do
      member do
        get :following, :followers
      end
    end
  end

  namespace :admin do
    resources :accounts
  end

  resources :relationships, only: %i[create destroy]

  resources :account_interests, only: %i[index update] do
    collection do
      get :connection
    end
  end

  resources :categories

  resources :maps, only: %i[index]

  resources :activities, only: %i[index]

  resources :posts do
    resource :comments
    resources :likes, only: %i[create destroy]
    resources :dislikes, only: %i[create destroy]
    collection do
      get :search_last
      get :most_comments
      get :most_likes
    end
  end

  get 'tags/:tag', to: 'posts#index', as: :tag
  get '/tags' => 'tags#index', as: 'tags'
  get 'search', to: 'search#search'
  mount Sidekiq::Web => '/sidekiq'
end
