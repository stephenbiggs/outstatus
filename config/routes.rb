Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "users#index"

  resources :users do
    member do
      get :confirm_email
      get :release_space
    end
  end
  
  resource :session
  
  resources :carspaces, path: "parking" do
    member do
      get :use_space
    end
  end

  resources :desks do
    member do
      get :book_desk
      get :cancel_desk
    end
  end

end
