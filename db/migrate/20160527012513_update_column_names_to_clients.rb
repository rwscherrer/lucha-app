class UpdateColumnNamesToClients < ActiveRecord::Migration
  def change
    rename_column :clients, :ssn, :encrypted_ssn
    rename_column :clients, :email, :encrypted_email
    rename_column :clients, :home_phone, :encrypted_home_phone
    rename_column :clients, :cell_phone, :encrypted_cell_phone
    rename_column :clients, :address, :encrypted_address
    rename_column :clients, :work_phone, :encrypted_work_phone
    rename_column :clients, :disability, :encrypted_disability
    rename_column :clients, :estimated_household_income, :encrypted_estimated_household_income

    add_column :clients, :encrypted_ssn_iv, :string
    add_column :clients, :encrypted_email_iv,:string
    add_column :clients, :encrypted_home_phone_iv ,:string
    add_column :clients, :encrypted_cell_phone_iv ,:string
    add_column :clients, :encrypted_address_iv ,:string
    add_column :clients, :encrypted_work_phone_iv ,:string
    add_column :clients, :encrypted_disability_iv ,:string
    add_column :clients, :encrypted_estimated_household_income_iv ,:string
  end
end
