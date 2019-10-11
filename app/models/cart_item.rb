class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price * quantity
  end

  def attributes_with_virtual
    attributes.merge("total_price" => total_price)
  end
end
