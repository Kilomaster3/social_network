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

  resources :interests, only: %i[update]

  resources :categories

  resources :maps, only: %i[index]

  resources :activities, only: %i[index]

  resources :posts do
    resource :comments
    resources :likes, only: %i[create destroy]
    resources :dislike, only: %i[create destroy]
  end

  get 'tags/:tag', to: 'posts_activities#index', as: :tag
  get '/interests' => 'interests#index', as: :interests_root
end
