class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.references :proposal, null: false, foreign_key: true

      t.references :seller, null: false, foreign_key: { to_table: 'users' }
      t.references :buyer, null: false, foreign_key: { to_table: 'users' }

      t.decimal :amount_due
      t.string :token, unique: true
      t.datetime :issue_date
      t.integer :status, default: 0

      t.timestamps
    end
  end
end