class Order < ApplicationRecord
  extend Enumerize

  validates :name, :address, :email, :pay_type, presence: true
  enumerize :pay_type, in: [:cash, :credit_card, :purchase_order]
end
