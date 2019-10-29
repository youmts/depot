class OrdersController < ApplicationController
  layout "user"

  before_action :set_order_pending_payment, only: %i[credit_card_form pay_credit_card]
  before_action :set_cart, only: %i[new create]

  # 必要になるまでシンプルに書いておく
  # before_action -> { redirect_to_store notice: "カートは空です"}, only: %i[new create], if: -> { @cart.items.empty? }
  before_action -> { redirect_to store_index_url, notice: "カートは空です" }, only: %i[new create], if: -> { @cart.items.empty? }

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params.merge(items: @cart.items.map{ |item| OrderItem.from_cart_item(item) }))

    if @order.save
      @cart.items.clear
      if @order.pay_type == :credit_card
        session[:order_id] = @order.id
        redirect_to credit_card_form_orders_url
      else
        redirect_to store_index_url, notice: I18n.t('.thanks')
      end
    else
      render :new
    end
  end

  def credit_card_form
  end

  # クレジット系の処理は別コントローラにまとめると役割がすっきりするかも
  # PaymentsController の new / createなど
  def pay_credit_card
    # 設定系なのでinitializerに移した方がよさそう
    Payjp::api_key = ENV['PAYJP_API_SECRET']

    # メソッドにわけるとスッキリしてみとおしがよくなりそう
    # PaymentsControllerにしてprivateメソッドにする（params[:payjp_token]のあたり）
    payjp_input = {
      amount: @order.total_price.to_i,
      card: params[:payjp_token],
      currency: 'jpy',
      capture: false,
      expiry_days: 1,
    }
    charge = nil

    @order.transaction do
      # 認証と支払額の確保
      charge = Payjp::Charge.create(payjp_input)
      logger.info "Payjp::Charge.create : #{payjp_input} => #{charge.id}"

      # 保存処理
      @order.update! status: :payment_received, pay_jp_charge_id: charge.id

      # 支払い処理を確定
      charge.capture
      logger.info "Payjp::Charge#capture : #{charge.id}"
    end

    redirect_to store_index_url, notice: I18n.t(".thanks_creditcard")

  #   例外キャッチのスコープが広いので、updateの部分のみに絞ると良さそう
  rescue
    # 確保した支払い額を返金
    if charge
      charge.refund
      logger.info "Payjp::Charge#retrieve : #{charge.id}"
    end
    raise
  end

  private

    def set_order_pending_payment
      @order = Order.find_by(id: session[:order_id], status: :pending_payment)
    end

    # ApplicationControllerにまかせた
    # def set_cart
    #   @cart = current_cart_or_create
    # end

    # YAGNI的に必要になった時に作りたい
    # def redirect_to_store(*args)
    #   redirect_to store_index_url, *args
    # end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
