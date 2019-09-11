Rails.application.routes.draw do
  root to: 'store#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # user
  scope '(:locale)' do
    resources :carts, only: [:destroy]
    resources :cart_items, only: [:create]
    resources :store, only: [:index, :show]
    resources :orders, only: [:new, :create] do
      member do
        get 'credit_card_form'
        post 'pay_credit_card'
      end
    end
  end
end
