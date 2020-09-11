class RemoveStatusCategoryFromProduct < ActiveRecord::Migration[6.0]
  change_table :products do |t|
    t.remove :category, :status
  end
end
