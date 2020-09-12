class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :picture
  has_many :comments
  has_many :messages
  # before_create :set_user
  
  validates :name, :description, :quantity, :price,
            presence: true

  enum status: { available: 0, unavailable: 10, suspended: 20 }
  enum condition: { not_informed: 0, new_product: 10, used: 20 }

  private

  # def set_user
  #   self.user = current_user
  # end
end
