Rails.application.routes.draw do
  get 'store/index'

  resources :products
  resources :carts
  resources :cart_items

  root to: 'store#index', as: 'store'
end
