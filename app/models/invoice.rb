class Invoice < ApplicationRecord
  belongs_to :proposal
  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'

  before_create :generate_token
  before_create :set_amount_due

  enum status: { finished: 0, cancelled: 10}

  
  def set_amount_due
    self.amount_due = proposal.quantity * proposal.proposed_price
  end
  
  def description(user)
    price_currency = amount_due.to_s
    price_currency['.']= ','
    return "#{proposal.product.name} - #{user.social_name} - R$ #{price_currency + '0'}"
  end

  private
  
  def generate_token
    self.token = SecureRandom.alphanumeric(6).upcase
  end
end
