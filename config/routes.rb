Rails.application.routes.draw do
  resources :payments

  resources :accounts

  root to: 'visitors#index'
  devise_for :users
end
