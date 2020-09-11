class RemoveConditionFromProduct < ActiveRecord::Migration[6.0]
  change_table :products do |t|
    t.remove :condition
  end
end
