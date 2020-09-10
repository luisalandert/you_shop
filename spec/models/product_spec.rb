require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      product = Product.new

      product.valid?

      expect(product.errors[:name]).to include('não pode ficar em branco')
      expect(product.errors[:description]).to include('não pode ficar em branco')
      expect(product.errors[:category]).to include('não pode ficar em branco')
      expect(product.errors[:quantity]).to include('não pode ficar em branco')
      expect(product.errors[:price]).to include('não pode ficar em branco')
      expect(product.errors[:condition]).to include('não pode ficar em branco')
      expect(product.errors[:user]).to include('é obrigatório(a)')
    end
  end
end
