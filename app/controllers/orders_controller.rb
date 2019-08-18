class OrdersController < ApplicationController
  layout "user"

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
      redirect_to store_index_url, notice: 'ご注文ありがとうございます'
    else
      render :new
    end
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
