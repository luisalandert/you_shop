feature 'User views product comments' do
  scenario 'successfully' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                  user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user_four = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                            social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                            job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                            status: :complete)
    another_user_four = User.create!(email: 'ana@empresaquatro.com.br', password:'abc123', full_name:'Ana Pacheco',
                                    social_name:'Ana Pacheco', birth_date:Date.parse('10/06/1980'),
                                    job_position: 'Desenvolvedora Mobile', department: 'Desenvolvimento', company: company_four,
                                    status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: alimentos, quantity: 5, price: 25.00, condition: :new_product, 
                              user: user_four , status: :available)
    Comment.create!(content: 'O pão de mel é recheado?', user: user_four, product: product)

    login_as(another_user_four, scope: :user)
    visit products_path
    click_on 'Pães de mel'

    expect(page).to have_link('Patricia Andrade')
    expect(page).to have_content('O pão de mel é recheado?')
  end

  scenario 'with comment from the seller' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user_four = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                            social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                            job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                            status: :complete)
    another_user_four = User.create!(email: 'ana@empresaquatro.com.br', password:'abc123', full_name:'Ana Pacheco',
                                    social_name:'Ana Pacheco', birth_date:Date.parse('10/06/1980'),
                                    job_position: 'Desenvolvedora Mobile', department: 'Desenvolvimento', company: company_four,
                                    status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: alimentos, quantity: 5, price: 25.00, condition: :new_product, 
                              user: user_four , status: :available)
    Comment.create!(content: 'O pão de mel é recheado com brigadeiro.', user: user_four, product: product)

    login_as(user_four, scope: :user)
    visit products_path
    click_on 'Pães de mel'

    expect(page).to have_link('Patricia Andrade (Vendedor(a)')
    expect(page).to have_content('O pão de mel é recheado com brigadeiro.')
  end
end