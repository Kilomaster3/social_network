Rails.application.routes.draw do
  devise_for :accounts, controllers: { omniauth_callbacks: 'account/omniauth_callbacks' }
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

  resources :relationships, only: %i[create destroy]

  resources :account_interests, only: %i[index update] do
    collection do
      get :max_connection
    end
  end

  resources :categories

  resources :maps, only: %i[index]

  resources :activities, only: %i[index]

  resources :posts do
    get 'search', to: 'search#search'
    get 'search/typeahead/:term', to: 'search#typeahead'
    resource :comments
    resources :likes, only: %i[create destroy]
    resources :dislike, only: %i[create destroy]
    collection do
      get :recent
      get :oldest
      get :search_last
    end
  end

  get 'tags/:tag', to: 'posts_activities#index', as: :tag
  get '/interests' => 'interests#index', as: :interests_root

end
