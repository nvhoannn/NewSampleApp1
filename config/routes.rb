Rails.application.routes.draw do
  root to: "static_pages#home"
  get 'static_pages/home'
  get 'static_pages/help'
  get "/sign_up", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
end

