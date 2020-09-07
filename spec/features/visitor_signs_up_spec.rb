feature 'Visitor signs up' do
  scenario 'successfully' do
    Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                    user_email: 'usuario@empresaum.com.br', email_domain: '@empresaum.com.br')

    visit root_path
    click_on 'Cadastrar'
    click_on 'Cadastrar Usuário'
    fill_in 'Email', with: 'user@empresaum.com.br'
    fill_in 'Senha', with: 'abcd12'
    fill_in 'Confirme sua senha',	with: 'abcd12'
    click_on 'Cadastrar'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(page).to have_content 'Perfil'
    expect(page).to have_content 'Sair'
    expect(page).not_to have_content 'Entrar'

    # TODO: pq no final do cadastro o usuário é redirecionado para o show da empresa com id 2?
    end

  scenario 'and goes back' do
    visit root_path
    click_on 'Cadastrar'
    click_on 'Cadastrar Usuário'
    click_on 'Voltar'

    expect(current_path).to eq register_path
  end

  scenario 'and company must be registered already' do
    visit root_path
    click_on 'Cadastrar'
    click_on 'Cadastrar Usuário'
    fill_in 'Email', with: 'user@empresamais.com.br'
    fill_in 'Senha', with: 'abcd12'
    fill_in 'Confirme sua senha',	with: 'abcd12'
    click_on 'Cadastrar'

    expect(page).to have_content 'corporativo não encontrado, empresa deve estar cadastrada para completar seu registro!'
  end
end

# TODO: testar o link cadastro de usuário (botão de baixo)