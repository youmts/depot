class AddStatusColumnToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :status, :string, default: "payment_received", null: false
  end
end
