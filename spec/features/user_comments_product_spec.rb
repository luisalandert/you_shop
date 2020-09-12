feature 'User comments on product page' do
  xscenario 'successfully' do
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
    Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                    category: alimentos, quantity: 5, price: 25.00, condition: :new_product, user: user_four , status: :available)
    
  end

  xscenario 'and content cannot be blank' do
  end

  xscenario 'and views owns comments on profile page' do
  end
end