class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def self.from_cart_item(item)
    OrderItem.new(item.attributes_with_virtual.slice("product_id", "quantity", "total_price"))
  end
end
