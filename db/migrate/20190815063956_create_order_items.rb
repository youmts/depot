class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      # 外部参照キー制約を追加したい
      # t.references :product, foreign_key: true 
      # t.references :cart, foreign_key: true
      t.references :order
      t.references :product
      t.integer :quantity
      t.decimal :total_price

      t.timestamps
    end
  end
end
