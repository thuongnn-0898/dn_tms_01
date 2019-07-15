# frozen_string_literal: true

Rails.application.routes.draw do
  root "users#index"

  namespace :supervisors do
    resources :users
    resources :trainees
    resources :supervisors
    resources :courses, except: :show
  end
end
