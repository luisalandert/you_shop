class ChangeDefaultOfCompanyAddress < ActiveRecord::Migration[6.0]
  def change
    change_column_default :companies, :address, from: 'Não informado', to: ''
  end
end
