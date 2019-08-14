Rails.application.routes.draw do
  resources :products
  resources :carts
  resources :cart_items

  resources :store, only: [:index, :show]

  root to: 'store#index'
end
