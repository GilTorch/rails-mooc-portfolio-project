Rails.application.routes.draw do

  # authentication
  get "/login",to:"sessions#new"
  post "/login",to:"sessions#create"
  post "/logout",to:"sessions#destroy"

  get "/auth/facebook/callback",to:"sessions#create"

  get "/",to:"application#home"

  resources :lessons
  resources :chapters
  resources :users
  resources :courses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
