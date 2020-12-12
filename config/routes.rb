Rails.application.routes.draw do
  scope '(:locale)', locale: /en|pl/ do
    root "homepage#index"
    devise_for :users
    
    resources :units, only: %i[ index show ]
    resources :bookings
    resources :homepage, only: %i[ index ]
    resources :checkout, only: %i[ index ]
    resources :additional_items, only: %i[ create update ]

    namespace :admin do
      root "units#index"

      resources :units, only: %i[ index create update show ]
      resources :additional_items, only: %i[ index create show update ] do
        resources :variants, only: %i[ create destroy ]
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
