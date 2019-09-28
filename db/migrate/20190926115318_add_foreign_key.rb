class AddForeignKey < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :products
  end
end
