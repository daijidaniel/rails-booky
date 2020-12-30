Rails.application.routes.default_url_options[:host] = ENV["HOST"]

Rails.application.routes.draw do

  scope '(:locale)', locale: /en|pl/ do
    if ENV['INPROGRESS'] == "true"
      root "static_pages#inprogress"
      get 'home', to: "homepage#index"
    else
      root "homepage#index"
    end

    devise_for :users
    
    resources :units, only: %i[ index show ]
    resources :bookings
    resources :homepage, only: %i[ index ]
    resources :checkout, only: %i[ index ]
    resources :additional_items, only: %i[ create update ]
    resources :payments, only: %i[ index create ]
    resources :addresses, only: %i[ create index ]
    resources :payment_notify, only: %i[ create ]
    resources :available_dates, only: %i[ index show ]
    resources :order_completed, only: %i[ index ]
    resources :contact_form, only: %i[ create ]

    namespace :admin do
      root "bookings#index"

      resources :users, only: %i[index create update show new]
      resources :bookings, only: %i[index create update show]
      resources :units, only: %i[ index create update show ]
      resources :additional_items, only: %i[ index create show update ] do
        resources :variants, only: %i[ create destroy ]
      end
    end

    get 'terms-of-service', to: 'static_pages#terms_of_service'
    get 'faq', to: 'static_pages#faq'
    get 'privacy-policy', to: 'static_pages#privacy_policy'
  end
end
