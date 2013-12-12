class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email_address, null: false
      t.string :address_street, null: false
      t.string :address_city, null: false
      t.string :address_postal_code, null: false
      t.string :address_country, null: false
      t.string :phone_number, null: false
      t.text :notes

      t.timestamps
    end
  end
end
