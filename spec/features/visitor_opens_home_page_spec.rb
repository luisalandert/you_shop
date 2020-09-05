require 'rails_helper' 

feature 'Visitor opens home page' do
  scenario 'sucessfully' do
    visit root_path

    expect(page).to have_content('Entrar')
    expect(page).to have_content('Cadastrar')
    expect(page).to have_content('you Shop')
    expect(page).to have_content('Conecte-se com colaboradores de sua empresa para anunciar e encontrar produtos dos mais variados!')
    expect(page).to have_content('Cadastre-se já!')
    expect(page).to have_content('Cadastro de Usuário')
    expect(page).to have_content('Cadastro de Empresa')
  end

end