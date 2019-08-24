class CartsController < ApplicationController
  def destroy
    @cart = current_cart_or_create
    @cart.items.clear

    respond_to do |format|
      format.js { render "carts/reload" }
      format.html { redirect_to store_index_url, notice: 'カートは現在空です' }
    end
  end
end
