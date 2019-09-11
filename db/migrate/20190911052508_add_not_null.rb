class AddNotNull < ActiveRecord::Migration[5.2]
  def up
    change_column :products, :title, :string, null: false
    change_column :products, :description, :text, null: false
    change_column :products, :price, :decimal, null: false

    change_column :orders, :name, :string, null: false
    change_column :orders, :address, :text, null: false
    change_column :orders, :email, :string, null: false
    change_column :orders, :pay_type, :string, null: false

    change_column :order_items, :quantity, :integer, null: false
    change_column :order_items, :total_price, :decimal, null: false

    change_column :cart_items, :quantity, :integer, null: false, default: nil
  end

  def down
    change_column :products, :title, :string, null: true, default: nil
    change_column :products, :description, :text, null: true, default: nil
    change_column :products, :price, :decimal, null: true, default: nil

    change_column :orders, :name, :string, null: true
    change_column :orders, :address, :text, null: true
    change_column :orders, :email, :string, null: true
    change_column :orders, :pay_type, :string, null: true

    change_column :order_items, :quantity, :integer, null: true
    change_column :order_items, :total_price, :decimal, null: true

    change_column :cart_items, :quantity, :integer, null: true, default: 1
  end
end
