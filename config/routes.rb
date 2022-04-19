Rails.application.routes.draw do
  root "photos#index"

  devise_for :users
  
  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  #resources :users, only: :show # this is equivalent to `get "users/:id" => "users#show", as: :user` but this will create /users/:username

  get "/:username/liked" => "photos#liked"
  get "/:username" => "users#show"

end
