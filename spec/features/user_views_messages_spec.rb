feature 'Seller views messages' do
  scenario 'successfully, in own product' do
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
    message_one = Message.create!(content: 'Estou interessada em comprar seus pães de mel mas gostaria de saber se você faz outros sabores.',
                                  sender: buyer_one, recipient: seller, product: product)
    message_two = Message.create!(content: 'Faço pães de mel somente com licor ou recheado com brigadeiro ou doce de leite.',
                                  recipient: buyer_one, sender: seller, product: product)

    login_as(seller, scope: :user)
    visit root_path
    click_on 'Patricia Andrade'
    click_on 'Pães de mel'

    expect(page).to have_content('Mensagens Privadas')
    expect(page).to have_content('Ana Pacheco')
    expect(page).to have_content(message_one.content)
    expect(page).to have_content('Você:')
    expect(page).to have_content(message_two.content)
  end

  scenario 'in another product' do
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
    buyer_two = User.create!(email: 'pedro@empresaquatro.com.br', password:'abc123', full_name:'Pedro Feitosa',
                             social_name:'Pedro Feitosa', birth_date:Date.parse('10/06/1980'),
                             job_position: 'Desenvolvedor iOS', department: 'Desenvolvimento', company: company_four,
                             status: :complete)
    alimentos = Category.create!(name: 'Alimentos')
    product = Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                              category: alimentos, quantity: 5, price: 25.00, condition: :new_product,
                              user: seller , status: :available)
    message_one = Message.create!(content: 'Estou interessada em comprar seus pães de mel mas gostaria de saber se você faz outros sabores.',
                                  sender: buyer_one, recipient: seller, product: product)
    message_two = Message.create!(content: 'Faço pães de mel somente com licor ou recheado com brigadeiro ou doce de leite.',
                                  sender: seller, recipient: buyer_one, product: product)
    message_three = Message.create!(content: 'Você tem sabor brigadeiro pra amanhã?',
                                    sender: buyer_two, recipient: seller, product: product)

login_as(buyer_two, scope: :user)
visit root_path
click_on 'Produtos'
click_on 'Pães de mel'

expect(page).to have_content('Mensagens Privadas')
expect(page).to have_content('Você:')
expect(page).to have_content(message_three.content)
expect(page).not_to have_content('Patricia Andrade:')
expect(page).not_to have_content(message_two.content)
expect(page).not_to have_content('Ana Pacheco:')
expect(page).not_to have_content(message_one.content)
  end
end