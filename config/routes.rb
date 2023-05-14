Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users

  root 'posts#index'

  resources :posts do
    resources :comments, only: %i[create destroy]
    resource :post_likes, only: %i[create destroy]
  end
end
