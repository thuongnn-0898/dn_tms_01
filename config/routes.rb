Rails.application.routes.draw do
  root "sessions#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  scope :user do
    get "/home", to: "homes#index"
    get "/details_task", to: "subject_users#details_task"
    patch "/finish_task", to: "progress_user_task#finish_task"
    patch "/finish_subject", to: "subject_users#finish_subject"
    resources :course_users
  end

  resources :courses, only: [:index, :show]
  get "/detail_tasks", to: "tasks#show"

  namespace :supervisors do
    resources :users
    resources :courses, except: :show
    resources :subjects
  end
end
