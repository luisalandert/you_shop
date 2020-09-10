class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :picture
  
  validates :name, :description, :category, :quantity, :price, :condition,
            presence: true

  enum status: { available: 0, unavailable: 10, suspended: 20 }
end
