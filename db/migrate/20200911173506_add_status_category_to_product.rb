class AddStatusCategoryToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :status, :integer, default: 0
    add_reference :products, :category, null: false, foreign_key: true
  end
end
