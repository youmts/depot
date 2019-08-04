class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :cart_items

  before_destroy :ensure_not_referenced_by_any_cart_item

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  private
    def ensure_not_referenced_by_any_cart_item
      if cart_items.empty?
        true
      else
        errors.add(:base, 'cart item exists')
        false
      end
    end
end
