Rails.application.routes.draw do
  devise_for :users
  root to: 'public#home'
  resources :dashboard, only: [:index, :create]
end
