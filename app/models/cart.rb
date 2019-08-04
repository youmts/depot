class Cart < ApplicationRecord
  has_many :items, class_name: "CartItem", foreign_key: :cart_id, dependent: :destroy
end
