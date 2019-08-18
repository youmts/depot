class AddPayJpChargeIdToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :pay_jp_charge_id, :string
  end
end
