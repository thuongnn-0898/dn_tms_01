# frozen_string_literal: true

Rails.application.routes.draw do
  root "users#index"

  namespace :supervisors do
    resources :users
    resources :courses, except: :show
  end
end
