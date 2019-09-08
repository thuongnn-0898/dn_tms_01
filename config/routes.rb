Rails.application.routes.draw do
  root "sessions#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/home", to: "homes#index"
  resources :course_users

  namespace :supervisors do
    resources :users
    resources :trainees, only: [:create, :destroy]
    get "/new/:id", to: "trainees#new", as: "assign"
    resources :courses
    resources :subjects
    resources :tasks, only: :destroy
  end

end
