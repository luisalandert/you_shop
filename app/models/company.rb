class Company < ApplicationRecord
  validates :name, :cnpj, presence: true
  validates :user_email, format: {with: /(\b@\b)|(\b.com\b)/, message: 'deve ser um email válido'}
end
