feature 'Visitor resgisters company' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastro de Empresa'
    fill_in 'Nome', with: 'Empresa Um'
    fill_in 'CNPJ', with: '08.262.335/7251-60'
    fill_in 'Endereço', with: 'Rua das Flores, 1008'
    fill_in 'Email do usuário', with: 'usuario@empresaum.com.br'
    click_on 'Enviar'

    expect(page).to have_content('Empresa Um')
    expect(page).to have_content('08.262.335/7251-60')
    expect(page).to have_content('Rua das Flores, 1008')
    expect(Company.last.email_domain).to eq '@empresaum.com.br'
  end
    # TODO: adicionar botão voltar

end