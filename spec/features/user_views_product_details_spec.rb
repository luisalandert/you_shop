feature 'User views product details' do
  scenario 'successfully' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user_four = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                            social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                            job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                            status: :complete)
    product = Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                    category: 'Decoração', quantity: 1, price: 30.00, condition: 'Novo', user: user_four , status: :available)

    login_as(user_four, scope: :user)
    visit root_path
    click_on 'Produtos'
    click_on 'Espelho decorado'

    expect(page).to have_css('.product-default')
    expect(page).to have_content(product.name)
    expect(page).to have_content(product.description)
    expect(page).to have_content(product.category)
    expect(page).to have_content(product.quantity)
    expect(page).to have_content('R$ 30,00')
    expect(page).to have_content(product.condition)
    expect(page).to have_content("Patricia Andrade - Desenvolvimento")
  end
end