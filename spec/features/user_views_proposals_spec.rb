feature 'User views proposals' do
  scenario 'received, from profile' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                              user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    buyer = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                         social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                         job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                         status: :complete)
    buyer_two = User.create!(email: 'renato@empresaquatro.com.br', password:'abc123', full_name:'Renato Peixoto',
                         social_name:'Renato Peixoto', birth_date:Date.parse('05/02/1982'),
                         job_position: 'Psicólogo', department: 'Recursos Humanos', company: company,
                         status: :complete)
    seller = User.create!(email: 'ana@empresaquatro.com.br', password:'abc123', full_name:'Ana Pacheco',
                          social_name:'Ana Pacheco', birth_date:Date.parse('10/06/1980'),
                          job_position: 'Desenvolvedora Mobile', department: 'Desenvolvimento', company: company,
                          status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: alimentos, quantity: 5, price: 25.00,
                              condition: :new_product, user: seller , status: :available)
    proposal_one = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 2)
    proposal_two = Proposal.create!(product: product, buyer: buyer_two, seller: seller, proposed_price: 20, quantity: 3)

    login_as(seller, scope: :user)
    visit root_path
    click_on 'Ana Pacheco'
    click_on 'Propostas'
    click_on 'Recebidas'

    expect(page).to have_content('Pães de mel - Patricia Andrade - R$ 25,00')
    expect(page).to have_content('Pães de mel - Renato Peixoto - R$ 20,00')

  end

  scenario 'sent, from profile' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                              user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    seller = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                         social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                         job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                         status: :complete)
    buyer = User.create!(email: 'ana@empresaquatro.com.br', password:'abc123', full_name:'Ana Pacheco',
                          social_name:'Ana Pacheco', birth_date:Date.parse('10/06/1980'),
                          job_position: 'Desenvolvedora Mobile', department: 'Desenvolvimento', company: company,
                          status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: alimentos, quantity: 5, price: 25.00,
                              condition: :new_product, user: seller , status: :available)
    proposal_one = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 2)

    login_as(buyer, scope: :user)
    visit root_path
    click_on 'Ana Pacheco'
    click_on 'Propostas'
    click_on 'Enviadas'

    expect(page).to have_content('Pães de mel - Patricia Andrade - R$ 25,00')

  end

  scenario 'and sees details' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                              user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    seller = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                         social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                         job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                         status: :complete)
    buyer = User.create!(email: 'ana@empresaquatro.com.br', password:'abc123', full_name:'Ana Pacheco',
                          social_name:'Ana Pacheco', birth_date:Date.parse('10/06/1980'),
                          job_position: 'Desenvolvedora Mobile', department: 'Desenvolvimento', company: company,
                          status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: alimentos, quantity: 5, price: 25.00,
                              condition: :new_product, user: seller , status: :available)
    proposal = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 2)

    login_as(seller, scope: :user)
    visit proposal_path(proposal.id)
 
    expect(page).to have_link('Pães de mel')
    expect(page).to have_content('Patricia Andrade')
    expect(page).to have_content('R$ 25,00', count: 2)
    expect(page).to have_content('2')
    expect(page).to have_content('Aguardando resposta')
  end

  scenario 'and there are no received proposals' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                              user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                          social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                          job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                          status: :complete)
    
    login_as(user, scope: :user)
    visit proposals_path
    click_on 'Recebidas'

    expect(page).to have_content('Nenhuma proposta recebida.')
  end

  scenario 'and there are no sent proposals' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                              user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                          social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                          job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                          status: :complete)
    
    login_as(user, scope: :user)
    visit proposals_path
    click_on 'Enviadas'

    expect(page).to have_content('Nenhuma proposta enviada.')
  end

  scenario 'rejected' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                              user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    buyer = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                         social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                         job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                         status: :complete)
    buyer_two = User.create!(email: 'renato@empresaquatro.com.br', password:'abc123', full_name:'Renato Peixoto',
                         social_name:'Renato Peixoto', birth_date:Date.parse('05/02/1982'),
                         job_position: 'Psicólogo', department: 'Recursos Humanos', company: company,
                         status: :complete)
    seller = User.create!(email: 'ana@empresaquatro.com.br', password:'abc123', full_name:'Ana Pacheco',
                          social_name:'Ana Pacheco', birth_date:Date.parse('10/06/1980'),
                          job_position: 'Desenvolvedora Mobile', department: 'Desenvolvimento', company: company,
                          status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: alimentos, quantity: 5, price: 25.00,
                              condition: :new_product, user: seller , status: :available)
    proposal_one = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 2)
    proposal_two = Proposal.create!(product: product, buyer: buyer_two, seller: seller, proposed_price: 20, quantity: 3, status: :denied)

    login_as(seller, scope: :user)
    visit root_path
    click_on 'Ana Pacheco'
    click_on 'Propostas'
    click_on 'Recebidas'
    click_on 'Rejeitadas'

    expect(page).to have_link('Pães de mel - Renato Peixoto - R$ 20,00')
    expect(page).not_to have_content('Pães de mel - Patricia Andrade - R$ 25,00')

  end

  scenario 'cancelled' do
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
    proposal_one = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 2)
    proposal_two = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 20, quantity: 3, status: :cancelled)

    login_as(buyer, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Propostas'
    click_on 'Enviadas'
    click_on 'Canceladas'

    expect(page).to have_link('Pães de mel - Ana Pacheco - R$ 20,00')
    expect(page).not_to have_content('Pães de mel - Ana Pacheco - R$ 25,00')

  end

end