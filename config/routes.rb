Rails.application.routes.draw do
  resource :session, only: %i[ new create destroy ]
  resource :registration, only: %i[ new create ]

  resources :lists, except: %i[ index new edit ] do
    resources :tasks, only: :create
    member { delete :clear_completed }
    collection { patch :sort }
  end

  resources :tasks, only: %i[ edit update destroy ] do
    member { patch :toggle }
    collection { patch :sort }
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#show"
end
