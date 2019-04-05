Rails.application.routes.draw do

  # authentication
  get "/login",to:"sessions#new"
  post "/login",to:"sessions#create"
  post "/logout",to:"sessions#destroy"

  get "/auth/facebook/callback",to:"sessions#create"

  get "/",to:"application#home",as:"root"
  
  get "/lessons/:id/complete",to:"lessons#complete",as:"complete_lesson"
  get "/lessons/:id/reset",to:"lessons#reset",as:"reset_lesson"
  get "/lessons/:id/validate",to:"lessons#validate",as:"validate_lesson"

  get "/courses/:id/reset",to:"courses#reset",as:"reset_course"
  get "/chapters/:id/reset",to:"chapters#reset",as:"reset_chapter"


  resources :lessons
  resources :chapters
  resources :users
  resources :courses
  resources :user_solutions, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
