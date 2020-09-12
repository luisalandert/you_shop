feature 'user searches products' do
  scenario 'partial search for name or description' do
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
    vestuario = Category.create!(name: 'Vestuário')
    decoracao = Category.create!(name: 'Decoração')
    Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                    category: alimentos, quantity: 5, price: 25.00, condition: :new_product, user: user_four , status: :available)
    Product.create!(name: 'Pães de queijo variados', description: '10 Pães de queijo variados, do tipo integral, normal e de mandioquinha.',
                    category: alimentos, quantity: 1, price: 100.00, condition: :used, user: user_four , status: :available)
    Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                    category: decoracao, quantity: 1, price: 30.00, condition: :new_product, user: another_user_four , status: :available)
    Product.create!(name: 'Chuteira', description: 'Chuteira Nike tamanho 38, usada poucas vezes.',
                    category: vestuario, quantity: 1, price: 50.00 , condition: :used, user: another_user_four, status: :available)

    login_as(user_four, scope: :user)
    visit root_path
    click_on 'Produtos'
    fill_in 'Busca', with: 'Pães'
    click_on 'Buscar'

    expect(page).to have_content('Pães de mel')
    expect(page).to have_content('Pães de queijo')
    expect(page).not_to have_content('Chuteira')
  end

  scenario 'and finds nothing' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user_four = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                             social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                             job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                             status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                    category: alimentos, quantity: 5, price: 25.00, condition: :new_product, user: user_four , status: :available)

    login_as(user_four, scope: :user)
    visit root_path
    click_on 'Produtos'
    fill_in 'Busca', with: 'Chuteira'
    click_on 'Buscar'

    expect(page).to have_content('Ainda não existem produtos cadastrados.')
    expect(page).not_to have_content('Pães de mel')
  end
end