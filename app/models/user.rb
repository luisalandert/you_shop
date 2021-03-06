class User < ApplicationRecord
  belongs_to :company
  has_many :products
  has_many :comments
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'sender_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'recipient_id'
  has_many :sent_proposals, :class_name => 'Proposal', :foreign_key => 'buyer_id'
  has_many :received_proposals, :class_name => 'Proposal', :foreign_key => 'seller_id'
  has_many :sent_invoices, :class_name => 'Invoice', :foreign_key => 'seller_id'
  has_many :received_invoices, :class_name => 'Invoice', :foreign_key => 'buyer_id'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_with CorporateEmailValidator

  enum status: {incomplete: 0, complete: 10}

end
