Rails.application.routes.draw do
  devise_for :accounts
  root to: 'public#home'
  resources :dashboard, only: %i[index create]

  namespace :account do
    resources :profiles
  end

  resources :posts do
    resource :comments
    resources :likes, only: %i[create destroy]
    resources :dislike, only: %i[create destroy]
  end

  get 'tags/:tag', to: 'posts#index', as: :tag
end
