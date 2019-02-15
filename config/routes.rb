Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :clients do
    collection do
      delete :delete_attachment
      get :handle_profile_change
    end
    member do
      put :link_activities
    end
  end
  resources :master_activities
  resources :activity_profiles
  resources :payment_histories

  get '/dashboard', to: 'dashboard#index'

  root to: 'dashboard#index'
end
