feature 'User views product details' do
  scenario 'must be signed in' do
    visit product_path(1)
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'successfully' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user_four = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                            social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                            job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                            status: :complete)
    decoracao = Category.create!(name: 'Decoração')
    product = Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                    category: decoracao, quantity: 1, price: 30.00, condition: :new_product, user: user_four , status: :available)

    login_as(user_four, scope: :user)
    visit root_path
    click_on 'Produtos'
    click_on 'Espelho decorado'

    expect(page).to have_css('.product-default')
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.description)
    expect(page).to have_content(product.category.name)
    expect(page).to have_content(product.quantity)
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content('Novo')
    expect(page).to have_content('Patricia Andrade - Desenvolvimento')
  end

  xscenario 'cannot view other users not available products' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user_four = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                             social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                             job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                             status: :complete)
    another_user_four = User.create!(email: 'paulo@empresaquatro.com.br', password:'abc123', full_name:'Paulo Andrade',
                            social_name:'Paulo Andrade', birth_date:Date.parse('11/03/1980'),
                            job_position: 'Product Owner', department: 'Desenvolvimento', company: company_four,
                            status: :complete)
    decoracao = Category.create!(name: 'Decoração')
    product = Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                              category: decoracao, quantity: 1, price: 30.00, condition: :new_product, 
                              user: another_user_four , status: :unavailable)
    product = Product.create!(name: 'Sapato', description: 'Tamanho 35',
      category: decoracao, quantity: 1, price: 30.00, condition: :new_product, 
      user: user_four , status: :available)

    login_as(user_four, scope: :user)
    visit products_path(1)

    # expect(page).to have_content('Produto indisponível!')
    # TODO: checar flash message
end
end