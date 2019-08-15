Rails.application.routes.draw do
  # admin
  resources :products

  # user
  resources :carts, only: [:show, :destroy]
  resources :cart_items, only: [:create]
  resources :store, only: [:index, :show]
  resources :orders, only: [:new, :create]

  root to: 'store#index'
end
