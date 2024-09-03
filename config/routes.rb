Rails.application.routes.draw do
  resources :characters, only: %i[index create]
  root "home#index"
  get "home/index"
  namespace :api do
    namespace :v1 do
      resources :characters, only: %i[index create show update destroy] do
        collection do
          get 'imported'
        end
      end
      get 'external_api/fetch_character/:id', to: 'external_api#fetch_character'
      resources :realms, only: %i[index]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
