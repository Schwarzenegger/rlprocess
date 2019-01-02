Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :clients
  resources :master_activities
  resources :activity_profiles

  root to: 'users#index'
end
