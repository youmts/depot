class Order < ApplicationRecord
  extend Enumerize

  has_many :items, -> { order "id" }, class_name: "OrderItem", foreign_key: :order_id, dependent: :destroy, inverse_of: :order
  accepts_nested_attributes_for :items

  validates :name, :address, :email, :pay_type, presence: true
  enumerize :pay_type, in: [:cash, :credit_card, :purchase_order]
  # TODO: default
  enumerize :status, in: [:pending_payment, :payment_received],
    default: :pending_payment, scope: true

  def add_items_from_cart(cart)
    cart.items.each do |cart_item|
      items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        total_price: cart_item.total_price)
    end
  end

  def total_price
    items.sum { |i| i.total_price }
  end
end
