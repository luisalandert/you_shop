feature 'Visitor registers company' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastro de Empresa'
    fill_in 'Nome', with: 'Empresa Um'
    fill_in 'CNPJ', with: '08.262.335/7251-60'
    fill_in 'Endereço', with: 'Rua das Flores, 1008'
    fill_in 'Email do usuário', with: 'usuario@empresaum.com.br'
    click_on 'Enviar'

    expect(current_path).to eq new_user_registration_path

  end
  
  # TODO: como garantir que só alguém da empresa que vai poder fazer o cadastro? algum regex com o email?

  scenario 'and goes back' do
    visit new_company_path
    click_on 'Voltar'

    expect(current_path).to eq companies_path
  end

  # TODO: adicionar cadastro de empresa na página de cadastro do botão da nav bar
end