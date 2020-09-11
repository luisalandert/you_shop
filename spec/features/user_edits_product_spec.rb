feature 'User edits product' do
  scenario 'successfully' do
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
    click_on 'Pães de mel'
    click_on 'Editar Anúncio'
    fill_in 'Nome', with: 'Pães de mel recheados'
    click_on 'Enviar'

    expect(current_path).to eq product_path(Product.last)
    expect(page).to have_content('Pães de mel recheados')
  end

  scenario 'from profile page' do
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
    click_on 'Patricia Andrade'
    click_on 'Pães de mel'
    
    expect(current_path).to eq product_path(Product.last)
  end
  scenario 'cannot edit other users products' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user_four = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                             social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                             job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                             status: :complete)
    another_user_four = User.create!(email: 'paulo@empresaquatro.com.br', password:'abc123', full_name:'Paulo Andrade',
                             social_name:'Paulo Andrade', birth_date:Date.parse('10/01/1980'),
                             job_position: 'Desenvolvedor Mobile', department: 'Desenvolvimento', company: company_four,
                             status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                    category: alimentos, quantity: 5, price: 25.00, condition: :new_product, user: user_four , status: :available)
    Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                    category: alimentos, quantity: 5, price: 25.00, condition: :new_product, user: user_four , status: :available)
  end
end