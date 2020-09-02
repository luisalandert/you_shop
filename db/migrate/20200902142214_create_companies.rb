class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.string :address
      t.string :user_email
      t.string :email_domain

      t.timestamps
    end
  end
end
