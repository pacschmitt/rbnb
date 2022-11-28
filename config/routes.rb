Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update]
  resources :gears, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :bookings, only: %i[new create destroy show]
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
