RSpec.describe Admin, type: :model do
  context 'validation' do
    it 'attributes cannot be blank' do
      admin = Admin.new

      admin.valid?

      expect(admin.errors[:name]).to include('não pode ficar em branco')
      expect(admin.errors[:email]).to include('não pode ficar em branco')
      expect(admin.errors[:password]).to include('não pode ficar em branco')
    end
  end

end
