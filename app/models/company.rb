class Company < ApplicationRecord
  validates :name, :cnpj, presence: true
  validates :user_email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/,
                                  message: 'deve ser um email válido'}
end
