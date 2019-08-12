class StoreController < ApplicationController
  def index
    @products = Product.order(:title)
    @cart = current_cart_or_create
  end
end
