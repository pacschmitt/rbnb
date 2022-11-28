Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update]
  resources :gears do
    resources :bookings, only: %i[new create]
  end
  resources :bookings, only: %i[destroy]
  # Defines the root path route ("/")
  # root "articles#index"
end
