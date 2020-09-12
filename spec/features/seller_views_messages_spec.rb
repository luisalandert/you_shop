feature 'Seller views messages' do
  scenario 'successfully' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                  user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    seller = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                          social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                          job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                          status: :complete)
    buyer_one = User.create!(email: 'ana@empresaquatro.com.br', password:'abc123', full_name:'Ana Pacheco',
                            social_name:'Ana Pacheco', birth_date:Date.parse('10/06/1980'),
                            job_position: 'Desenvolvedora Mobile', department: 'Desenvolvimento', company: company_four,
                            status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: alimentos, quantity: 5, price: 25.00, condition: :new_product,
                              user: seller , status: :available)
    product_two = Product.create!(name: 'Bolo no pote', description: 'Bolo de 200g, sabores variados.',
                              category: alimentos, quantity: 5, price: 10.00, condition: :new_product,
                              user: seller , status: :available)
    message_one = Message.create!(content: 'Estou interessada em comprar seus pães de mel mas gostaria de saber se você faz outros sabores.',
                    user: buyer_one, product: product)
    message_two = Message.create!(content: 'Gostaria de 2 bolos de maracujá para essa sexta, será que é possível?',
                    user: buyer_one, product: product_two)

    login_as(seller, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Mensagens'
    click_on 'Ana Pacheco'

    expect(page).to have_content('Mensagens de Ana Pacheco')
    expect(page).to have_content('Pães de mel')
    expect(page).to have_content(message_one.content)
    expect(page).to have_content('Bolo no pote')
    expect(page).to have_content(message_two.content)

  end

  scenario 'from multiple buyers' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    seller = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                            social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                            job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                            status: :complete)
    buyer_one = User.create!(email: 'ana@empresaquatro.com.br', password:'abc123', full_name:'Ana Pacheco',
                                    social_name:'Ana Pacheco', birth_date:Date.parse('10/06/1980'),
                                    job_position: 'Desenvolvedora Mobile', department: 'Desenvolvimento', company: company_four,
                                    status: :complete)
    buyer_two = User.create!(email: 'pedro@empresaquatro.com.br', password:'abc123', full_name:'Pedro Pereira',
                            social_name:'Pedro Pereira', birth_date:Date.parse('05/06/1980'),
                            job_position: 'Desenvolvedor Mobile', department: 'Desenvolvimento', company: company_four,
                            status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                             category: alimentos, quantity: 5, price: 25.00, condition: :new_product,
                             user: seller , status: :available)
    Message.create!(content: 'Estou interessada em comprar seus pães de mel mas gostaria de saber se você faz outros sabores.',
                    user: buyer_one, product: product)
    Message.create!(content: 'Você aceita encomendas em quantidades maiores?',
                    user: buyer_two, product: product)

    login_as(seller, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Mensagens'
    
    expect(page).to have_link('Pedro Pereira')
    expect(page).to have_link('Ana Pacheco')
    
  end
end