class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :store_name
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :postal_code
      t.string :country
      t.string :state

      t.timestamps
    end
  end
end
