class AddForeignKey < ActiveRecord::Migration[5.2]
  def up
    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :products
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
