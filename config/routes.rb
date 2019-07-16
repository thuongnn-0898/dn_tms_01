Rails.application.routes.draw do
  root "sessions#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/home", to: "homes#index"

  namespace :supervisors do
    resources :users
    resources :trainees
    resources :courses
    resources :supervisors
    require "sidekiq/web"
    mount Sidekiq::Web, at: "/sidekiq"
  end
end
