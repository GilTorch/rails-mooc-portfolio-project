Rails.application.routes.draw do

  # authentication
  get "/login",to:"sessions#new"
  post "/login",to:"sessions#create"
  post "/logout",to:"sessions#destroy",as:"logout"

  get "/auth/facebook/callback",to:"sessions#create"

  get "/",to:"application#home",as:"root"
  
  get "/lessons/:id/complete",to:"lessons#complete",as:"complete_lesson"
  get "/lessons/:id/reset",to:"lessons#reset",as:"reset_lesson"
  get "/lessons/:id/validate",to:"lessons#validate",as:"validate_lesson"

  get "/courses/:id/reset",to:"courses#reset",as:"reset_course"
  get "/chapters/:id/reset",to:"chapters#reset",as:"reset_chapter"


    get "/admin",to:"admin#home",as:"admin_root"
    get "admin/lessons/:id/validate",to:"admin/lessons#validate",as:"admin_validate_lesson"

  namespace :admin do 
    resources :users, only: [:index,:show,:create,:edit,:update,:destroy,:delete]
    resources :courses, only: [:index,:show,:create,:edit,:update,:destroy,:delete]
    resources :chapters, only: [:index,:show,:create,:edit,:update,:destroy,:delete]
    resources :lessons, only: [:index,:show,:create,:edit,:update,:destroy,:delete]
    resources :user_solutions, only:[:show]
  end

  resources :lessons
  resources :chapters
  resources :users
  resources :courses
  resources :user_solutions, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
