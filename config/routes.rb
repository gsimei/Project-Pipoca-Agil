Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: 'users/registrations' }

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/email_confirmation", to: "pages#email_confirmation", as: "email_confirmation"
  get "/privacy", to: "pages#privacy", as: "privacy"
end
