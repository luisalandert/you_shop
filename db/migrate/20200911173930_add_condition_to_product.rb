class AddConditionToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :condition, :integer, default: 0
  end
end
