Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :clients do
    collection do
      delete :delete_attachment
    end
    member do
      put :link_activities
    end
  end
  resources :master_activities
  resources :activity_profiles

  root to: 'users#index'
end
