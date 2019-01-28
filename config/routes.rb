Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :clients do
    collection do
      delete :delete_attachment
    end
  end
  resources :master_activities
  resources :activity_profiles

  root to: 'users#index'
end
