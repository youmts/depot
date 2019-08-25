class StoreController < ApplicationController
  layout 'user'

  def index
    if params[:set_locale]
      redirect_to store_index_path(locale: params[:set_locale])
    else
      @products = Product.order(:title)
      @cart = current_cart_or_create
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end


