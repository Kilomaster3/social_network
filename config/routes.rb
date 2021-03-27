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

  resources :activities, only: %i[index]

  resources :posts do
    resource :comments
    resources :likes, only: %i[create destroy]
    resources :dislike, only: %i[create destroy]
  end

  get 'tags/:tag', to: 'posts#index', as: :tag
  get '/saw_notification', to: 'accounts#saw_notification', as: 'saw_notice'
end
