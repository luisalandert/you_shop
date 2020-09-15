feature 'Seller suspends product' do
  scenario 'successfully' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    seller = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                             social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                             job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                             status: :complete)
    decoracao = Category.create!(name: 'Decoração')
    product = Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                              category: decoracao, quantity: 1, price: 30.00, condition: :new_product, user: seller , status: :available)

    login_as(seller, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Espelho decorado'
    click_on 'Suspender Anúncio'

    product.reload
    expect(product.suspended?).to eq true
    expect(current_path).to eq product_path(product.id)
    expect(page).to have_content('Produto suspenso!')
  
  end

  scenario 'and makes available again' do
    company = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    seller = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                             social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                             job_position: 'Tech Lead', department: 'Desenvolvimento', company: company,
                             status: :complete)
    decoracao = Category.create!(name: 'Decoração')
    product = Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                              category: decoracao, quantity: 1, price: 30.00, condition: :new_product, user: seller , status: :suspended)

    login_as(seller, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Espelho decorado'
    click_on 'Ativar Anúncio'

    product.reload
    expect(product.available?).to eq true
    expect(current_path).to eq product_path(product.id)
    expect(page).to have_content('Produto ativado!')
  
  end
end