class Product < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :image, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
