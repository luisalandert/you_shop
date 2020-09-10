class RemoveStatusFromProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :state, :integer
  end
end
