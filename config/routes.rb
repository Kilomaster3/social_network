Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'public#home'
  resources :dashboard, only: [:index, :create]
end
