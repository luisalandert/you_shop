feature 'Seller responds to received proposal' do
  scenario 'as accepted' do
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

    login_as(seller, scope: :user)
    visit proposals_path
    click_on 'Recebidas'
    click_on proposal.description(buyer)
    click_on 'Aceitar'

    proposal.reload
    expect(proposal.approved?).to eq true
    expect(page).to have_content('Venda finalizada com sucesso!')
    expect(current_path).to eq invoice_path(Invoice.last)
  end
  scenario 'as denied' do
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

    login_as(seller, scope: :user)
    visit proposals_path
    click_on 'Recebidas'
    click_on proposal.description(buyer)
    click_on 'Rejeitar'

    proposal.reload
    expect(proposal.denied?).to eq true
    expect(page).to have_content('Proposta recusada!')
    expect(current_path).to eq received_proposals_path
  end

  scenario 'as cancelled' do
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

    login_as(buyer, scope: :user)
    visit proposals_path
    click_on 'Enviadas'
    click_on proposal.description(seller)
    click_on 'Cancelar'

    proposal.reload
    expect(proposal.cancelled?).to eq true
    expect(page).to have_content('Proposta cancelada')
    expect(current_path).to eq sent_proposals_path
  end

  xscenario 'only seller can accept' do
  end

  xscenario 'only seller can reject' do
  end

  xscenario 'only buyer can cancel' do
  end
  
end
