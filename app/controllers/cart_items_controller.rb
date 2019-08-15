class CartItemsController < ApplicationController
  def create
    @cart = current_cart_or_create
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product.id)

    if @cart_item.save
      render "carts/reload"
    else
      redirect_to "/", flash: { error: "カートへの商品の追加に失敗しました" }
    end
  end
end
