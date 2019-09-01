Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # admin
  resources :products

  # user
  scope '(:locale)' do
    resources :carts, only: [:destroy]
    resources :cart_items, only: [:create]
    resources :store, only: [:index, :show]
    resources :orders, only: [:new, :create] do
      member do
        get 'credit_card_form'
        get 'pay_success'
        get 'pay_cancel'
      end
    end

    root to: 'store#index'
  end
end
