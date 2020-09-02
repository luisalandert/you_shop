xfeature 'Visitor resgisters company' do
  scenario 'successfully' do
    visit root_path
    click_on 'Cadastro de Empresa'
    fill_in 'Nome', with: 'Empresa_um'
    fill_in 'CNPJ', with: '08.262.335/7251-60'
    fill_in 'Endereço', with: 'Rua das Flores, 1008'
    # TODO: terminar teste

  end
end