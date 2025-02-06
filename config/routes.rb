Rails.application.routes.draw do
  root "static_pages#home"
  get "/signup", to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :posts
  resources :categories, only: [:new, :destroy, :create]
  resources :skills

  resources :users do
    resources :companies, only: [:new, :create, :destroy]
    resources :user_skills, only: [:new, :create, :edit, :update, :destroy]
    resources :projects, only: [:new, :create, :edit, :update, :destroy]
    resources :project_skills, only: [:new, :create, :destroy] 
  end
end