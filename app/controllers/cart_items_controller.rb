class CartItemsController < ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  # GET /cart_items
  def index
    @cart_items = CartItem.all
  end

  # GET /cart_items/1
  def show
  end

  # GET /cart_items/new
  def new
    @cart_item = CartItem.new
  end

  # GET /cart_items/1/edit
  def edit
  end

  # POST /create
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

  # PATCH/PUT /cart_items/1
  def update
    if @cart_item.update(cart_item_params)
      redirect_to @cart_item, notice: 'Cart item was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cart_items/1
  def destroy
    @cart_item.destroy!
    redirect_to cart_items_url, notice: 'Cart item was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cart_item_params
      params.fetch(:cart_item, {})
    end
end
