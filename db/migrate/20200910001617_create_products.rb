class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :category
      t.integer :quantity
      t.decimal :price
      t.string :condition
      t.references :user, null: false, foreign_key: true
      t.integer :state

      t.timestamps
    end
  end
end
