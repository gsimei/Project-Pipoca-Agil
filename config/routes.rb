Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions'
  }


  root to: "pages#home"

  get "/email_confirmation", to: "pages#email_confirmation", as: "email_confirmation"
  get "/privacy", to: "pages#privacy", as: "privacy"
end
