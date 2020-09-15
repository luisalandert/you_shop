require 'rails_helper'

RSpec.describe Invoice, type: :model do
  context '.set_amount_due' do
    it 'should return proposed_price times quantity' do
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
      invoice = Invoice.create!(proposal: proposal, buyer: buyer, seller: seller, issue_date: Time.zone.now)
      invoice.amount_due = invoice.set_amount_due()

      expect(invoice.amount_due).to eq 50
    end
    context 'token' do
      it 'generate on create' do
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
        invoice = Invoice.new(proposal: proposal, buyer: buyer, seller: seller, issue_date: Time.zone.now)

        invoice.save!

        expect(invoice.token).to be_present
        expect(invoice.token.size).to eq(6)
        expect(invoice.token).to match(/^[A-Z0-9]+$/)

      end
    end
  end
end
