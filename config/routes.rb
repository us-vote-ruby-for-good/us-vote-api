Rails.application.routes.draw do
  devise_for :users

  root 'admin/states#index'

  namespace :admin do
    resources :users
    resources :states, only: [:index, :show]  
  end

  namespace :api do
    resources :states, only: [] do
      resources :elections, only: [:index]
    end
  end
end
