Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'devise_extensions/registrations',
    sessions: 'devise_extensions/sessions' 
  }
  
  resources :page_module_collections do
    resources :modules, controller: 'page_modules', only: [:index, :new]
  end
  
  resources :page_modules, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :edit, :update, :destroy]
  
  resources :settings, only: [:index, :edit, :update] do
    collection do
      put :updates
    end
  end
  
  root to: 'home#index'
end