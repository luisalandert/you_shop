feature 'User views invoices' do
  scenario 'sent' do
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
    product_two = Product.create!(name: 'Bolo no pote', description: 'Bolo recheado sabor chocolate ou maracujá. Bolo de 200g.',
                              category: alimentos, quantity: 10, price: 10.00,
                              condition: :new_product, user: seller , status: :available)
    proposal = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 2)
    proposal_two = Proposal.create!(product: product_two, buyer: buyer, seller: seller, proposed_price: 10, quantity: 1)
    invoice = Invoice.create!(proposal: proposal, buyer: buyer, seller: seller, issue_date: Time.zone.now)
    invoice.amount_due = invoice.set_amount_due()
    invoice.token = 'ABC123'
    invoice_two = Invoice.create!(proposal: proposal_two, buyer: seller, seller: buyer, issue_date: Time.zone.now)
    invoice_two.amount_due = invoice_two.set_amount_due()
    invoice_two.token = 'ABCDEF'

    login_as(seller, scope: :user)
    visit root_path
    click_on 'Ana Pacheco'
    click_on 'Histórico de Compra e Venda'
    click_on 'Recibos Enviados'

    expect(page).to have_content('Pães de mel - Patricia Andrade - R$ 50,00')
    expect(page).not_to have_content('Bolo no pote - Patricia Andrade - R$ 10,00')
  end

  scenario 'received' do
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
    product_two = Product.create!(name: 'Bolo no pote', description: 'Bolo recheado sabor chocolate ou maracujá. Bolo de 200g.',
                              category: alimentos, quantity: 10, price: 10.00,
                              condition: :new_product, user: seller , status: :available)
    proposal = Proposal.create!(product: product, buyer: buyer, seller: seller, proposed_price: 25, quantity: 2)
    proposal_two = Proposal.create!(product: product_two, buyer: buyer, seller: seller, proposed_price: 10, quantity: 1)
    invoice = Invoice.create!(proposal: proposal, buyer: buyer, seller: seller, issue_date: Time.zone.now)
    invoice.amount_due = invoice.set_amount_due()
    invoice.token = 'ABC123'
    invoice_two = Invoice.create!(proposal: proposal_two, buyer: seller, seller: buyer, issue_date: Time.zone.now)
    invoice_two.amount_due = invoice_two.set_amount_due()
    invoice_two.token = 'ABCDEF'

    login_as(buyer, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Histórico de Compra e Venda'
    click_on 'Recibos Recebidos'

    expect(page).to have_content('Pães de mel - Ana Pacheco - R$ 50,00')
    expect(page).not_to have_content('Bolo no pote - Patricia Andrade - R$ 10,00')
  end

  scenario 'and there are no received invoices' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                              user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    buyer = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                        social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                        job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                        status: :complete)
    
    login_as(buyer, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Histórico de Compra e Venda'
    click_on 'Recibos Recebidos'

    expect(page).to have_content('Nenhum recido encontrado.')

  end

  scenario 'and there are no sent invoices' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                              user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    seller = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                        social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                        job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                        status: :complete)
    
    login_as(seller, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Histórico de Compra e Venda'
    click_on 'Recibos Enviados'

    expect(page).to have_content('Nenhum recido encontrado.')

  end

  scenario 'and view details' do
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
    invoice = Invoice.create!(proposal: proposal, buyer: buyer, seller: seller, issue_date: Date.current)

    login_as(buyer, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Histórico de Compra e Venda'
    click_on 'Recibos Recebidos'
    click_on 'Pães de mel - Ana Pacheco - R$ 50,00'

    expect(page).to have_content("Pedido #{invoice.token}")
    expect(page).to have_content('Pães de mel')
    expect(page).to have_content('2')
    expect(page).to have_content('R$ 25,00')
    expect(page).to have_content('Patricia Andrade', count:2)
    expect(page).to have_content('Ana Pacheco')
    expect(page).to have_content('R$ 50,00')
    
  end
end