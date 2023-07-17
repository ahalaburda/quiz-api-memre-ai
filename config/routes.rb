Rails.application.routes.draw do
  resources :quizzes, only: [:create, :show, :destroy]
end