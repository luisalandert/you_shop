class Proposal < ApplicationRecord
  belongs_to :product
  belongs_to :buyer, :class_name => 'User'
  belongs_to :seller, :class_name => 'User'

  validates :proposed_price, :quantity, presence: true

  enum status: { waiting: 0, denied: 10, cancelled: 20, approved: 30}

  def description(user)
    price_currency = proposed_price.to_s
    price_currency['.']= ','
    return "#{product.name} - #{user.social_name} - R$ #{price_currency + '0'}"
  end
end
