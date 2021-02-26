Rails.application.routes.draw do
  devise_for :accounts
  root to: 'public#home'
  resources :dashboard, only: [:index, :create]
end
