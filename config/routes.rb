Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :auth, only: [] do
        collection do
          post :login, to: 'auth#login'
          post :verify, to: 'auth#verify'
          post :register, to: 'auth#register'

        end
      end
    end
  end
end
