Rails.application.routes.draw do
  devise_for :accounts
  root to: 'public#home'
  resources :dashboard, only: [:index, :create]
  namespace :account do
    resources :profiles
  end
  resources :posts
  get 'tags/:tag', to: 'posts#index', as: :tag
end
