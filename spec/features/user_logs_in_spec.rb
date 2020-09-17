feature 'User logs in' do
  scenario 'successfully' do
    company = Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                              user_email: 'usuario@empresa.com.br', email_domain: '@empresa.com.br')
    user = User.create!(full_name: 'João da Silva', social_name: 'João da Silva',
                        birth_date: Date.parse('10/10/1990'), job_position: 'Engenheiro de software',
                        department: 'TI', email: 'joao@empresa.com.br', password: '123abc', company: company)

    visit root_path 
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'commit'

    expect(page).to have_content(user.full_name)
    expect(page).to have_content('Sair')
    expect(page).not_to have_content('Entrar')
  end

  scenario 'and logs out' do
    company = Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                              user_email: 'usuario@empresa.com.br', email_domain: '@empresa.com.br')
    user = User.create!(full_name: 'João da Silva', social_name: 'João da Silva',
                        birth_date: Date.parse('10/10/1990'), job_position: 'Engenheiro de software',
                        department: 'TI', email: 'joao@empresa.com.br', password: '123abc', company: company)

    visit root_path 
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'commit'
    click_on 'Sair'

    expect(page).to have_content('Entrar')
    expect(page).not_to have_content('Sair')

  end

  scenario 'and there is no button to register company or user' do
    company = Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                              user_email: 'usuario@empresa.com.br', email_domain: '@empresa.com.br')
    user = User.create!(full_name: 'João da Silva', social_name: 'João da Silva',
                        birth_date: Date.parse('10/10/1990'), job_position: 'Engenheiro de software',
                        department: 'TI', email: 'joao@empresa.com.br', password: '123abc', company: company)

    visit root_path 
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'commit'

    expect(page).not_to have_content('Cadastro de Usuário')
    expect(page).not_to have_content('Cadastro de Empresa')
  end

  scenario 'and connot access company registration page with link' do
    company = Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                              user_email: 'usuario@empresa.com.br', email_domain: '@empresa.com.br')
    user = User.create!(full_name: 'João da Silva', social_name: 'João da Silva',
                        birth_date: Date.parse('10/10/1990'), job_position: 'Engenheiro de software',
                        department: 'TI', email: 'joao@empresa.com.br', password: '123abc', company: company)

    login_as(user, scope: :user)
    visit new_company_path

    expect(page).to have_content('Sua empresa já está cadastrada. Para cadastrar outra empresa faça o log out e use o email corporativo da nova empresa.')
  end
end