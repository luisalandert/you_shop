feature 'User views companies' do
  scenario 'successfully' do
    Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                    user_email: 'usuario@empresaum.com.br')
    Company.create!(name: 'Empresa Dois', cnpj: '08.262.335/7251-10', address: 'Rua Direita, 78', 
                    user_email: 'usuario@empresadois.com.br')

    visit root_path
    click_on 'Empresas Cadastradas'

    expect(page).to have_content('Empresa Um')
    expect(page).to have_content('Empresa Dois')
    expect(page).not_to have_content('08.262.335/7251-60')
  end

  scenario 'and there are no companies' do
    visit root_path
    click_on 'Empresas Cadastradas'

    expect(page).to have_content('Nenhuma empresa cadastrada')
  end

  scenario 'and must be signed in to view details' do
    Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                    user_email: 'usuario@empresaum.com.br')

    visit companies_path
    click_on 'Empresa Um'

    expect(page).to have_content('Para continuar, faça login ou registre-se.')
  end
  
  scenario 'and views details' do
    Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008',
                    user_email: 'usuario@empresaum.com.br', email_domain: '@empresaum.com.br')
    Company.create!(name: 'Empresa Dois', cnpj: '08.262.335/7251-10', address: 'Rua Direita, 78',
                    user_email: 'usuario@empresadois.com.br', email_domain: '@empresadois.com.br')
    user = User.create!(email: 'joao@empresadois.com.br', password: '123abc')

    login_as(user, scope: :user)
    visit companies_path
    click_on 'Empresa Um'

    expect(page).to have_content('Empresa Um')
    expect(page).to have_content('08.262.335/7251-60')
    expect(page).to have_content('Rua das Flores, 1008')
    expect(page).to have_content('usuario@empresaum.com.br')
    expect(page).not_to have_content('Empresa Dois')
  end

  scenario 'and goes back to home page' do
    visit root_path
    click_on 'Empresas Cadastradas'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
  
  scenario 'and goes to company registry page' do
    visit root_path
    click_on 'Empresas Cadastradas'
    click_on 'Registrar Empresa'

    expect(current_path).to eq new_company_path
  end
  # TODO: adicionar busca pelo nome
  # TODO: adicionar botaão voltar no show de empresas
end