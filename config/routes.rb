require 'sidekiq/web'

Rails.application.routes.draw do
  root "recipes#index"
  mount Sidekiq::Web => "/sidekiq"
  resources :users, shallow: true, only: %i[index create destroy] do
    resources :recipes
    collection do
      get :users_profile
      get :all_followees
      get :all_followers
    end
  end
  post 'user/login', to: 'authentication#login'
  post '/users/:id/follow', to: 'users#follow', as: 'follow_user'
  post '/users/:id/unfollow', to: 'users#unfollow', as: 'unfollow_user'

  post 'likes/create/:id', to: 'likes#create'
  delete 'likes/dislike/:id', to: 'likes#dislike'

  post 'comments/create/:id', to: 'comments#create'
  put  'comments/update/:id/:comment_id', to: 'comments#update'
  delete 'comments/delete/:id', to: 'comments#delete'

  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'

  get 'accounts/index', to: 'accounts#index'

end
