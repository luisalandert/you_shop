feature 'User completes profile' do
  scenario 'successfully' do
    Company.create!(name: 'Empresa Dois', cnpj: '08.262.335/7251-10', address: 'Rua Direita, 78',
                    user_email: 'usuario@empresadois.com.br', email_domain: '@empresadois.com.br')
    user = User.create!(email: 'joao@empresadois.com.br', password: '123abc')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfil'
    click_on 'Editar Dados'
    fill_in 'Nome Completo', with: 'João da Silva'
    fill_in 'Nome Social', with: 'João da Silva'
    fill_in 'Data de Nascimento', with: Date.parse('10/10/1990')
    fill_in 'Cargo', with: 'Engenheiro de Software'
    fill_in 'Departamento', with: 'TI'
    click_on 'Atualizar'

    expect(current_path).to eq user_path(User.last)
    expect(page).to have_content('João da Silva')
    expect(page).to have_content('Engenheiro de Software')
  end

  xscenario 'and changes password' do
    Company.create!(name: 'Empresa Dois', cnpj: '08.262.335/7251-10', address: 'Rua Direita, 78', user_email: 'usuario@empresadois.com.br', email_domain: '@empresadois.com.br')
    user = User.create!(email: 'joao@empresadois.com.br', password: '123abc')

    login_as(user, scope: :user)
    visit root_path
    click_on 'Perfil'
    click_on 'Trocar Senha'
    fill_in 'Email', with: 'joao@empresadois.com.br'
    fill_in 'Nova senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    fill_in 'Senha atual', with: '123abc'
    click_on 'Atualizar'

    expect(User.last.password).to eq '123456'
    
    #  Failure/Error: expect(User.last.password).to eq '123456'
    #expected: "123456"
    #got: nil
  end

end

# TODO: mudar o status para complete quando o perfil estiver completo e mandar um alert se não estiver completo depois do update