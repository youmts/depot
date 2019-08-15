class StoreController < ApplicationController
  layout 'user'

  def index
    @products = Product.order(:title)
    @cart = current_cart_or_create
  end

  def show
    @product = Product.find(params[:id])
  end
end


