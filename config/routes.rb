Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'point_of_sales#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :dashboard
  resources :point_of_sales do
    member do
      post :add_to_cart
      post :remove_item
      post :draft
      post :confirm_and_complete_order
      post :complete
    end
  end
  resources :products do
    member do 
      post :archive
      post :active
      post :recover
    end
  end
  resources :receipts
  resources :orders do
    member do
      post :add_note
      post :continue_cart
      post :process_void
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root to: "site#index"
end
