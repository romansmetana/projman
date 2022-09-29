# frozen_string_literal: true

Rails.application.routes.draw do
  post 'searches/search'
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :projects
  resources :tasks do
    get 'download_file', to: 'tasks#download_file'
  end
  resources :tags

  # Defines the root path route ("/")
  root 'projects#index'
end
