feature 'User views products page' do
  scenario 'and must be signed in' do
    visit products_path

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
    expect(current_path).to eq new_user_session_path
  end
  
  scenario 'and only products from his company are showed' do
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
    company_one = Company.create!(name:'Empresa Um', cnpj: '15.841.968/4394-20', address: 'Av. Paulista, 1007, São Paulo, SP',
                                  user_email: 'user@empresaum.com', email_domain: '@empresaum.com')
    user_one = User.create!(email: 'joao@empresaum.com', password:'abc123', full_name:'João da Silva',
                            social_name:'João da Silva', birth_date:Date.parse('15/05/1987'),
                            job_position: 'Advogado', department: 'Jurídico', company: company_one ,
                            status: :complete)
    Product.create!(name: 'Pães de mel', description: 'Caixa com 6 pães de mel ao leite com licor de chocolate.',
                    category: 'Alimentos', quantity: 5, price: 25.00, condition: 'New', user: user_four , status: :available)
    Product.create!(name: 'Jaqueta jeans', description: 'Jaqueta jeans Shoulder tamanho 40 em ótimo estado.',
                    category: 'Vestuário', quantity: 1, price: 100.00, condition: 'Usada', user: user_four , status: :available)
    Product.create!(name: 'Espelho decorado', description: 'Espelho decorado pintado à mão.',
                    category: 'Decoração', quantity: 1, price: 30.00, condition: 'Novo', user: another_user_four , status: :available)
    Product.create!(name: 'Chuteira', description: 'Chuteira Nike tamanho 38, usada poucas vezes.',
                    category: 'Vestuário', quantity: 1, price: 50.00 , condition: 'Usada', user: user_one, status: :available)
    
    login_as(user_four, scope: :user)
    visit root_path
    click_on 'Produtos'

    expect(page).to have_content('Produtos de Empresa Quatro')
    expect(page).to have_content('Pães de mel')
    expect(page).to have_content('R$ 25,00')
    expect(page).to have_content('Patricia Andrade - Desenvolvimento', count: 2)
    expect(page).to have_content('Jaqueta jeans')
    expect(page).to have_content('Espelho decorado')
    expect(page).to have_content('Ana Pacheco - Desenvolvimento')
    expect(page).not_to have_content('Chuteira')

  end
  # TODO: adicionar imagem a produto!
  

  scenario 'and there are no products' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user_four = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                             social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                             job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                             status: :complete)

    login_as(user_four, scope: :user)
    visit root_path
    click_on 'Anúncios de Produtos'

    expect(page).to have_content('Ainda não existem produtos cadastrados.')
  end
  
end