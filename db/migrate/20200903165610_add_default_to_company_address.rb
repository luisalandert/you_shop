class AddDefaultToCompanyAddress < ActiveRecord::Migration[6.0]
  def change
    change_column_default :companies, :address, 'Não informado'
  end
end
