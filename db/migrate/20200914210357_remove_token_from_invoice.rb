class RemoveTokenFromInvoice < ActiveRecord::Migration[6.0]
  def change
    remove_column :invoices, :token, :string
  end
end
