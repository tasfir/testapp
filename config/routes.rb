Rails.application.routes.draw do
  resources :groups
  resources :publications
  resources :parties
  resources :products
  resources :brands
  resources :users
  resources :divisions, only: %i[index show]
  get "inventory", to: "inventory#index", as: :inventory
  get "reports", to: "reports#index", as: :reports
  resource :profile, only: %i[show edit update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"

  get "login", to: "sessions#new", as: :login
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: :logout

  get "coming-soon", to: "pages#coming_soon", as: :coming_soon

  get "districts(/:division_id)", to: "districts#index", as: "districts"
  get "thanas(/:district_id)", to: "thanas#index", as: "thanas"
end
