Rails.application.routes.draw do

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  get "users/:id/likes" => "users#likes"
  post "logout" => "users#logout"
  post "login" => "users#login"
  get "login_form" => "users#login_form"
  post "users/:id/update" => "users#update"
  get "users/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/index" => "users#index"
  get "users/:id" => "users#show"

  post "posts/create" => "posts#create"
  get "posts/new" => "posts#new"
  get "posts/index" => "posts#index"
  post "posts/:id/update" => "posts#update"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/destroy" => "posts#destroy"
  get "posts/:id" => "posts#show"

  get "/" => "home#top"
end
