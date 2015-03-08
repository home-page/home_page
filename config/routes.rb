Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'devise_extensions/registrations',
    sessions: 'devise_extensions/sessions' 
  }
  
  resources :users, only: [:index, :edit, :update, :destroy]
  
  root to: 'home#index'
end