Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root to: "pages#home"

  get "/email_confirmation", to: "pages#email_confirmation", as: "email_confirmation"
  get "/privacy", to: "pages#privacy", as: "privacy"
end
