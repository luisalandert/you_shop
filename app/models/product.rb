class Product < ApplicationRecord
  belongs_to :user

  enum status: { available: 0, unavailable: 10, suspended: 20 }
end
