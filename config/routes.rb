Rails.application.routes.draw do
  devise_for :accounts, controllers: { omniauth_callbacks: 'account/omniauth_callbacks' }
  root to: 'public#home'
  resources :dashboard, only: %i[index create]

  namespace :account do
    resources :profiles
    resource :friendships, only: %i[create] do
      collection do
        get 'accept_friend'
        get 'decline_friend'
      end
    end
  end

  resources :posts do
    resource :comments
    resources :likes, only: %i[create destroy]
    resources :dislike, only: %i[create destroy]
  end

  get 'tags/:tag', to: 'posts#index', as: :tag
  get '/saw_notification', to: 'accounts#saw_notification', as: 'saw_notice'
end
