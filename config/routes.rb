Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'devise_extensions/registrations' }
  
  resources :users, only: [:index, :edit, :update, :destroy]
  
  root to: 'home#index'
end