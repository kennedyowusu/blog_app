Rails.application.routes.draw do
  root 'posts#index'
  resources:posts

  get '/users/:user_id/posts/:id', to: 'posts#show'
  resources :users, only: [:index, :show] do
  resources :posts, only: [:index, :show]

  end

end
