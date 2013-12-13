class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.datetime :last_accessed

      t.timestamps
    end
  end
end
