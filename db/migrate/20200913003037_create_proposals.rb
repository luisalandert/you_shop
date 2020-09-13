class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.references :product, null: false, foreign_key: true

      t.references :buyer, null: false, foreign_key: { to_table: 'users' }
      t.references :seller, null: false, foreign_key: { to_table: 'users' }

      t.integer :quantity
      t.decimal :proposed_price

      t.timestamps
    end
  end
end
