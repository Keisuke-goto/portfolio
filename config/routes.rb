Rails.application.routes.draw do
  resources :notifications, only: :index
  
  post'subscription/create' => 'subscriptions#create'
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]

  get 'upload/index' =>'upload#index'
  get 'upload/new' => 'upload#new'
  post 'upload/create' => 'upload#create'
  get 'upload/:id' => 'upload#show'
  
  get "login" => 'user#login_form'
  post "login" => "user#login"
  post "logout" => "user#logout"

  post "user/:id/update" => "user#update"
  get "user/:id/edit" => "user#edit"
  get "user/index" => "user#index"
  get "user/:id" => "user#show"
  get "singup" => "user#new"
  post "user/create" => "user#create"

  get '/' => "home#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
