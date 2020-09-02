class RemoveEmailPasswordFromAdmin < ActiveRecord::Migration[6.0]
  def change 
    change_table :admins do |t|
      t.remove :email, :password
    
    end
  end
end
