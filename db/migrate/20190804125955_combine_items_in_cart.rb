class CombineItemsInCart < ActiveRecord::Migration[5.2]
  def up
    Cart.all.each do |cart|
      cart.items.group(:product_id).sum(:quantity).each do |product_id, quantity|
        next if quantity <= 1
        cart.items.where(product_id: product_id).delete_all
        cart.items.create(product_id: product_id, quantity: quantity)
      end
    end
  end
end
