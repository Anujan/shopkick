class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :stores, :name, unique: true
    add_index :stores, :email, unique: true
  end
end
