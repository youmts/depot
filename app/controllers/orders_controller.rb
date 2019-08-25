class OrdersController < ApplicationController
  layout "user"

  before_action :set_order_pending_peyment, only: [:credit_card_form, :pay_credit_card]

  def new
    @cart = current_cart_or_create
    if @cart.items.empty?
      redirect_to store_url, notice: "カートは空です"
      return
    end

    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    cart = current_cart_or_create
    @order.add_items_from_cart(cart)

    if @order.save
      cart.items.clear
      if @order.pay_type == :credit_card
        redirect_to credit_card_form_order_url(@order)
      else
        redirect_to store_index_url, notice: I18n.t('.thanks')
      end
    else
      render :new
    end
  end

  def credit_card_form
  end

  def pay_credit_card
    Payjp::api_key = ENV['PAYJP_API_SECRET']

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

  rescue
    # 確保した支払い額を返金
    if charge
      charge.refund
      logger.info "Payjp::Charge#retrieve : #{charge.id}"
    end
    raise
  end

  private

    def set_order_pending_peyment
      # TODO そのセッションで持っているOrderかどうかチェックする
      # TODO .where(status: :pending_payment)
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
