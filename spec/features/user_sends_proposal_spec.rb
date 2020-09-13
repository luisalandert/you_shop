xfeature 'User sends proposal' do
  scenario 'successfully' do
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
                              category: alimentos, quantity: 5, price: 25.00, condition: :new_product, user: seller , status: :available)
    
    login_as(buyer, scope: :user)
    visit products_path
    click_on 'Pães de mel'
    click_on 'Fazer Proposta'
    select 'Pães de mel - Patricia Andrade - R$ 25,00', from: 'Produto'
    fill_in 'Preço Proposto', with: '25'
    fill_in 'Quantidade', with: '1'
    click_on 'Enviar Proposta'

    expect(page).to have_content('Proposta enviada com sucesso!')
    expect(page).to have_link('Pães de mel')
    expect(page).to have_content('Patricia Andrade')
    expect(page).to have_content('R$ 25,00')
    expect(page).to have_content('1')
    expect(page).to have_content(Proposal.last.status)
  end
end