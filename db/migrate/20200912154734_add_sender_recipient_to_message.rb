class AddSenderRecipientToMessage < ActiveRecord::Migration[6.0]
  def change
    change_table(:messages) do |t|
      t.references :sender, foreign_key: { to_table: 'users' }
      t.references :recipient, foreign_key: { to_table: 'users' }
  end
  end
end
