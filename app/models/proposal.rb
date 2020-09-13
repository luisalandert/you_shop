class Proposal < ApplicationRecord
  belongs_to :product
  belongs_to :buyer, :class_name => 'User'
  belongs_to :seller, :class_name => 'User'

  enum status: { waiting: 0, denied: 10, cancelled: 20, approved: 30}

end
