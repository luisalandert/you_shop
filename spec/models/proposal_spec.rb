require 'rails_helper'

RSpec.describe Proposal, type: :model do
  context 'validation' do
    it 'no attributes can be blank' do
      proposal = Proposal.new()

      proposal.valid?

      expect(proposal.errors[:proposed_price]).to include('não pode ficar em branco')
      expect(proposal.errors[:quantity]).to include('não pode ficar em branco')
      expect(proposal.errors[:seller]).to include('é obrigatório(a)')
      expect(proposal.errors[:buyer]).to include('é obrigatório(a)')
      expect(proposal.errors[:product]).to include('é obrigatório(a)')
    end
  end
  context '.description' do
    it 'should return product name, buyer name and proposed price' do
      company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
      buyer = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                           social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                           job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                           status: :complete)
      seller = User.create!(email: 'ana@empresaquatro.com.br', password:'abc123', full_name:'Ana Pacheco',
                            social_name:'Ana Pacheco', birth_date:Date.parse('10/06/1980'),
                            job_position: 'Desenvolvedora Mobile', department: 'Desenvolvimento', company: company,
                            status: :complete)
      alimentos = Category.create!(name: 'Alimentos')
      product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                                category: alimentos, quantity: 5, price: 25.00,
                                condition: :new_product, user: seller , status: :available)
      proposal = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 2)

      result = proposal.description(buyer)

      expect(result).to eq 'Pães de mel - Patricia Andrade - R$ 25,00'
    end
  end
end
