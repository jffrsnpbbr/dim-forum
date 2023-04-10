Rails.application.routes.draw do
  devise_for :users

  root 'posts#index'

  resources :users, only: [:index, :show] do
    get 'posts', to: 'users#posts'
    get 'comments', to: 'users#comments'
  end

  resources :posts, path: '/' do
    resources :comments
  end

  resources :categories
end