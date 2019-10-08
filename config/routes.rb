Rails.application.routes.draw do
  root to: 'store#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # user
  # application_controller.rb で設定されている
  #
  # /carts
  # /ja/carts
  # /en/carts
  scope '(:locale)' do
    # cartsはセッションで管理しているので、resourceをネストさせていない
    resources :carts, only: [:destroy]
    resources :cart_items, only: [:create]

    # resources :products, only: [:index, :show] がしっくりきました
    # %i[index show] で簡潔に書いておきたい（`%i()`はRubocopで指摘される）
    # Pythonの場合＞[aaa] == pushもできるふつうの配列 ,  (aaa) == const(tupleになる)
    resources :store, only: [:index, :show]

    resources :orders, only: [:new, :create] do
      # order と payments が1:1なので、resourceでよさそう
      # get/ postをたくさんつくると複雑になっていきがちなので、resourceでまとめて
      # おくと、グルーピングの意味もかねてよさそう。
      # resource :payments, only: [:new, :create]
      #    ↑（collectionはこのかたちに置き換えるとすっきりする）
      # 決済の状態は、注文(orders)にstatusでもっているので、orders#updateで済ませる？
      collection do
        get 'credit_card_form'
        post 'pay_credit_card'
      end
    #   orders 注文、payments 支払い、invoice 領収書などを考慮するかで設計が変わりそう。
    end
  end
end
