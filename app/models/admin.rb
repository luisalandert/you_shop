class Admin < ApplicationRecord
  validates :name, :email, :password, presence: true
end
