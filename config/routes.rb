Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users,shallow: true, only:[:index,:create,:destroy] do
    resources :recipes
  end
  post 'user/login', to: 'authentication#login'
end
