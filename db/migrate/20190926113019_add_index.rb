class AddIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :cart_items, [:cart_id, :product_id], unique: true
    remove_index :cart_items, :cart_id

    add_index :order_items, [:order_id, :product_id], unique: true
    remove_index :order_items, :order_id
  end
end
