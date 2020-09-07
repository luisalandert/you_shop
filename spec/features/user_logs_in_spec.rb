feature 'User logs in' do
  scenario 'successfully' do
    Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                    user_email: 'usuario@empresa.com.br', email_domain: '@empresa.com.br')
    user = User.create!(full_name: 'João da Silva', social_name: 'João da Silva',
                        birth_date: Date.parse('10/10/1990'), job_position: 'Engenheiro de software',
                        department: 'TI', email: 'joao@empresa.com.br', password: '123abc')

    visit root_path 
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    expect(page).to have_content(user.full_name)
    expect(page).to have_content('Sair')
    expect(page).not_to have_content('Entrar')
  end

  # TODO: se o perfil não estiver completo mostrar 'Perfil' ao invés do nome completo

  scenario 'and logs out' do
    Company.create!(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                    user_email: 'usuario@empresa.com.br', email_domain: '@empresa.com.br')
    user = User.create!(full_name: 'João da Silva', social_name: 'João da Silva',
                        birth_date: Date.parse('10/10/1990'), job_position: 'Engenheiro de software',
                        department: 'TI', email: 'joao@empresa.com.br', password: '123abc')

    visit root_path 
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'
    click_on 'Sair'

    expect(page).to have_content('Entrar')
    expect(page).not_to have_content('Sair')

  end
end