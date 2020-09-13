class Product < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :picture
  has_many :comments
  has_many :messages
  
  validates :name, :description, :quantity, :price,
            presence: true

  enum status: { available: 0, unavailable: 10, suspended: 20 }
  enum condition: { not_informed: 0, new_product: 10, used: 20 }

  def info
    price_currency = price.to_s
    price_currency['.']= ','
    return "#{name} - #{user.social_name} - R$ #{price_currency + '0'}"
  end
end
