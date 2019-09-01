class OrdersController < ApplicationController
  layout "user"

  before_action :set_order, only: [:credit_card_form, :pay_success, :pay_cancel]

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
    @stripe_session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: 'depot',
        description: @order.joined_product_titles,
        amount: @order.total_price.to_i,
        currency: 'jpy',
        quantity: 1,
      }],
      success_url: pay_success_order_url(@order),
      cancel_url: pay_cancel_order_url(@order),
    )
  end

  def pay_success
    redirect_to store_index_url, notice: I18n.t(".thanks_creditcard")
  end

  def pay_cancel

    redirect_to store_index_url, notice: I18n.t(".cancel_creditcard")
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
