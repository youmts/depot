class OrdersController < ApplicationController
  layout "user"

  before_action :set_order, only: [:credit_card_form, :pay_credit_card]

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
        redirect_to store_index_url, notice: 'ご注文ありがとうございます'
      end
    else
      render :new
    end
  end

  def credit_card_form
  end

  def pay_credit_card
    # TODO クレジットカード支払い(pay.jp)

    @order.status = :payment_received
    # TODO 支払いトークンの保存
    @order.save!

    redirect_to store_index_url, notice: 'ご注文ありがとうございます（クレジットカード支払い済み）'

    # TODO 保存失敗時のクレジットカードキャンセル
  end


  private
    def set_order
      # TODO そのセッションで持っているOrderかどうかチェックする
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
