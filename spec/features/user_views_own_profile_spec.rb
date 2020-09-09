feature 'User views own profile' do
  scenario 'successfully' do
    company = Company.create!(name: 'Empresa Dois', cnpj: '08.262.335/7251-10', address: 'Rua Direita, 78',
                    user_email: 'usuario@empresadois.com.br', email_domain: '@empresadois.com.br')
    user = User.create!(email: 'joao@empresadois.com.br', password: '123abc', full_name: 'João Pessoa',
                        social_name: 'João Pessoa', birth_date: Date.parse('10/10/1990'),
                        job_position: 'Advogado', department: 'Jurídico', status: :complete, company: company)

    login_as(user, scope: :user)
    visit root_path
    click_on 'João Pessoa'
    expect(page).to have_content('João Pessoa')
    expect(page).to have_content('10/10/1990')
    expect(page).to have_content('Advogado')
    expect(page).to have_content('Jurídico')
  end
end