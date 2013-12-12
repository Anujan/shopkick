class ChangeAddressFormat < ActiveRecord::Migration
  def change
    add_column :customers, :address_state, :string
    remove_column :profiles, :address
    remove_column :profiles, :country
    remove_column :profiles, :postal_code
    remove_column :profiles, :state
    add_column :profiles, :address_street, :string
    add_column :profiles, :address_country, :string
    add_column :profiles, :address_state, :string
    add_column :profiles, :address_postal_code, :string
    add_column :profiles, :address_city, :string
  end
end
