# frozen_string_literal: true

Rails.application.routes.draw do
  root "users#index"

  scope :supervisor do
    resources :users
  end
end
