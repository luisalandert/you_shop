class User < ApplicationRecord
  belongs_to :company
  has_many :products

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_with CorporateEmailValidator

  enum status: {incomplete: 0, complete: 10}

end
