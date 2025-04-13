Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "sessions#new"

  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/dashboard", to: "dashboard#index"

  namespace :merchant do
    get "dashboard", to: "dashboard#index"
  end
  
  namespace :admin do
    get "dashboard", to: "dashboard#index"
  end

  resources :users, only: [:new, :create]
  resources :transactions, only: [:new, :create, :index] do
    collection do
      post :confirmation_transfer
    end
  end

end
