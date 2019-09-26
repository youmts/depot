class AddIndex < ActiveRecord::Migration[5.2]
  def up
    add_index :cart_items, [:cart_id, :product_id], unique: true
    remove_index :cart_items, column: :cart_id

    add_index :order_items, [:order_id, :product_id], unique: true
    remove_index :order_items, column: :order_id
  end

  def down
    remove_index :cart_items, column: [:cart_id, :product_id]
    add_index :cart_items, :cart_id

    remove_index :order_items, column: [:order_id, :product_id]
    add_index :order_items, :order_id
  end
end
