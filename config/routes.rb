Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'devise_extensions/registrations',
    sessions: 'devise_extensions/sessions' 
  }
  
  resources :pages
  
  resources :page_module_collections do
    resources :modules, controller: 'page_modules', only: [:index, :new] do
      collection do
        put :move
      end
    end
  end
  
  resources :page_modules, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :page_module_collections_modules, only: [:create, :destroy]
  
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  
  resources :settings, only: [:index, :show, :edit, :update] do
    collection do
      put :updates
    end
  end
  
  root to: 'home#index'
end