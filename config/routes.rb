Rails.application.routes.draw do
  resources :payments

  get "/users/upload" => "users#upload_page", as: "users_upload_page"

  resources :accounts
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  resources :users

  root to: 'home#index'
  post "/users/add_user" => "users#create", :as => "add_user"
  # post "/users/update_user" => "users#update", :as => "update_user"

  post "/upload_users" => "users#bulk_upload", :as => "upload_users", via: [:post]
  post "/users/delete_multiple" => "users#delete_multiple", as: "delete_multiple_users"
  post "/payments/delete_multiple" => "payments#delete_multiple", as: "delete_multiple_payments"
  post "/payments/:id/withdraw" => "payments#withdraw", as: "withdraw"
  post "/payments/:id/send_through_mpesa" => "payments#send_through_mpesa", as: "send_through_mpesa"
end
