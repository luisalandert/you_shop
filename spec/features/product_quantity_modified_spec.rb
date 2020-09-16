feature 'Product quantity is modified when invoice is created' do
  scenario 'successfully' do
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
    proposal = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 5)

    login_as(seller, scope: :user)
    visit proposal_path(proposal.id)
    click_on 'Aceitar'

    product.reload()
    expect(proposal.product.quantity).to eq 0
    expect(product.unavailable?).to eq true

  end
  scenario 'successfully' do
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
    proposal = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 5)

    login_as(seller, scope: :user)
    visit proposal_path(proposal.id)
    click_on 'Aceitar'
    click_on 'Cancelar'

    product.reload()
    expect(proposal.product.quantity).to eq 5
    expect(product.available?).to eq true

  end
end

