class ApplicationController < ActionController::Base
  helper_method :current_cart_or_create

  private

    def current_cart_or_create
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end
