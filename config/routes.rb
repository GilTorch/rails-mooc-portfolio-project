Rails.application.routes.draw do
  resources :user_lessons
  resources :user_chapters
  resources :user_courses
  resources :lessons
  resources :chapters
  resources :users
  resources :courses
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
