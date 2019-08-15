require "rails_helper"

RSpec.describe Order do
  describe "add_line_items_from_cart" do
    let(:cart) { create(:cart_with_items) }

    example "カートの内容が全てコピーされること" do
      order = Order.new
      order.add_items_from_cart(cart)

      cart.items.each_with_index do |cart_item, i|
        order_item = order.items[i]
        expect(order_item.product).to eq cart_item.product
        expect(order_item.quantity).to eq cart_item.quantity
        expect(order_item.total_price).to eq cart_item.total_price
        expect(order_item.valid?).to be_truthy
      end
    end
  end
end
