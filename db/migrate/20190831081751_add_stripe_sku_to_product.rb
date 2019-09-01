class AddStripeSkuToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :stripe_sku, :string
  end
end
