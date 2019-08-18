class ChangeColumnToOrder < ActiveRecord::Migration[5.2]
  def up
    change_column :orders, :status, :string, default: "pending_payment", null: false
  end

  def down
    change_column :orders, :status, :string, default: "payment_received", null: false
  end
end
