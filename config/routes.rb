Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :clients

  root to: 'users#index'
end
