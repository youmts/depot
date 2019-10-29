class ApplicationController < ActionController::Base
  helper_method :current_cart_or_create
  before_action :set_i18n_locale_from_params

  private

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end

    def default_url_options
      { locale: I18n.locale }
    end

    # @cartはここで定義して、必要なコントローラーが適宜呼び出すようにする
    def set_cart
      @cart ||= Cart.find_or_create_by!(id: session[:cart_id])
      session[:cart_id] = @cart.id
    end
end
