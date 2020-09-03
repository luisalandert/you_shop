require 'rails_helper'

RSpec.describe Company, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      company = Company.new

      company.valid?

      expect(company.errors[:name]).to include('não pode ficar em branco')
      expect(company.errors[:cnpj]).to include('não pode ficar em branco')
      expect(company.errors[:user_email]).to include('deve ser um email válido')

    end

    xit 'email must be valid' do
      company = Company.new(name: 'Empresa Um', cnpj: '08.262.335/7251-60', address: 'Rua das Flores, 1008', 
                            user_email: 'usuario@empresaum')

      company.valid?

      expect(company.errors[:user_email]).to include('deve ser um email válido')
    end
  end
end
