Rails.application.routes.draw do

  get "/" => "home#index"

  resources :users
  resources :menu_categories
  resources :menu_items

  get "/owners" => "owners#index"
  get "/customers" => "customers#index"

  get "/signin" => "sessions#new", as: :owner_sessions_page
  post "/signin" => "sessions#create_customer", as: :customer_sessions
  post "/signin-owner" => "sessions#create_owner", as: :owner_sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

