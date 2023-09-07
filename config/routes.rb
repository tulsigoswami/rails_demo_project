Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users,shallow: true, only:[:index,:create,:destroy] do
    resources :recipes
    collection do
      get :users_profile
      get :all_followees
      get :all_followers
    end
  end
  post 'user/login', to: 'authentication#login'
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"

  post 'likes/create/:id', to:'likes#create'
  delete 'likes/dislike/:id', to:'likes#dislike'

   post 'comments/create/:id', to:'comments#create'
   put  'comments/update/:id/:comment_id', to:'comments#update'
   delete 'comments/delete/:id', to:'comments#delete'
end
