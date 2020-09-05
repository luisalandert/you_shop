feature 'User logs in' do
  scenario 'successfully' do
    user = User.create!(full_name: 'João da Silva', social_name: 'João da Silva',
                        birth_date: Date.parse('10/10/1990'), job_position: 'Engenheiro de software',
                        department: 'TI', email: 'joao@email.com', password: '123abc')

    visit root_path 
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Entrar'

    expect(page).to have_content(user.full_name)
    expect(page).to have_content('Sair')
    expect(page).not_to have_content('Entrar')
  end
end
User.create!(full_name: 'Usuário', social_name: 'Usuário',
  birth_date: Date.parse('10/10/1990'), job_position: 'Engenheiro de software',
  department: 'TI', email: 'user@email.com', password: '123abc')