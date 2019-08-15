class CartsController < ApplicationController
  before_action :set_cart, only: [:show]

  def show
  end

  def destroy
    @cart = current_cart_or_create
    @cart.items.clear

    respond_to do |format|
      format.js { render "carts/reload" }
      format.html { redirect_to store_index_url, notice: 'カートは現在空です' }
    end
  end

  private
    def set_cart
      @cart = Cart.find(params[:id])
    end
end
