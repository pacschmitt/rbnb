Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "/about", to: "pages#about"
  get "/faq", to: "pages#faq"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update] do
    resources :gears, only: [:index]
  end
  resources :gears do
    resources :bookings, only: %i[new create]
  end
  resources :bookings, only: %i[destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
