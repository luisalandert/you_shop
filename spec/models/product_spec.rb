require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      product = Product.new

      product.valid?

      expect(product.errors[:name]).to include('não pode ficar em branco')
      expect(product.errors[:description]).to include('não pode ficar em branco')
      expect(product.errors[:category]).to include('é obrigatório(a)')
      expect(product.errors[:quantity]).to include('não pode ficar em branco')
      expect(product.errors[:price]).to include('não pode ficar em branco')
      expect(product.errors[:user]).to include('é obrigatório(a)')
    end
  end
  context '.info' do
    it 'returns proposal name and user social name' do
      company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
      user = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                          social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                          job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                          status: :complete)
      decoracao = Category.create!(name: 'Decoração')
      product = Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                                category: decoracao, quantity: 1, price: 30.00, condition: :new_product,
                                user: user , status: :available)

      result = product.info()

      expect(result).to eq 'Espelho decorado - Patricia Andrade - R$ 30,00'
    end
  end
end
