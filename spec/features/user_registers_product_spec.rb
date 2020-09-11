feature 'User registers product' do
  scenario 'must be signed in' do
    visit new_product_path
    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end

  scenario 'successfully' do
    company_four = Company.create!(name:'Empresa Quatro', cnpj: '65.943.509/7880-04', address: 'Av. Tucuruvi, 562, São Paulo, SP',
                                   user_email: 'user@empresaquatro.com.br', email_domain: '@empresaquatro.com.br')
    user_four = User.create!(email: 'patricia@empresaquatro.com.br', password:'abc123', full_name:'Patricia Andrade',
                             social_name:'Patricia Andrade', birth_date:Date.parse('11/02/1980'),
                             job_position: 'Tech Lead', department: 'Desenvolvimento', company: company_four,
                             status: :complete)
    Category.create(name: 'Cuidado Pessoal')

    login_as(user_four, scope: :user)
    visit root_path
    click_on 'Cadastrar Produto'
    fill_in 'Nome', with: 'Sabonete artesanal'
    fill_in 'Descrição', with: 'Sabonete de orquídea e figos, vegano e 100% natural. Caixa com 2 unidades.'
    fill_in 'Preço', with: '20'
    select 'Cuidado Pessoal', from: 'product_category_id'
    fill_in 'Quantidade', with: '5'
    select 'Novo', from: 'product_condition'
    attach_file 'Foto', Rails.root.join('app/assets/images/sabonete.jpg')
    click_on 'Enviar'
    expect(current_path).to eq product_path(1)
  end
end