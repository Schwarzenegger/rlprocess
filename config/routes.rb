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

  resources :activities, only: [:update, :show] do
    member do
      put :start
      put :finish
      put :restart
      put :archive
    end
    collection do
      put :mark_option
    end
  end

  get '/dashboard', to: 'dashboard#index'

  root to: 'dashboard#index'
end
