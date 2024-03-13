Rails.application.routes.draw do
  get 'meal_ingredients/index'
  get 'meal_ingredients/new'
  get 'meal_ingredients/create'
  get 'ingredients/new'
  get 'ingredients/create'
  get 'ingredients/index'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :ingredients, only: %i[new create index]
  resources :users do
    resources :meals, only: %i[new create] do
      resources :meal_ingredients, only: %i[index new create]
    end
  end
  resources :meal_ingredients, only: %i[destroy]
  resources :meals, only: %i[show destroy edit update] do
    resources :carts, only: %i[create new edit update]
  end

  resources :carts, only: %i[destroy index] do
    collection do
      get 'shoppinglist'
    end
  end
end
