class UpdateColumnNamesToClients < ActiveRecord::Migration
  def change
    rename_column :clients, :ssn, :encrypted_ssn
    add_column :clients, :encrypted_ssn_iv, :string
  end
end
