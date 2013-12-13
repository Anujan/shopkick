class CreateCartProducts < ActiveRecord::Migration
  def change
    create_table :cart_products do |t|
      t.integer :product_id
      t.integer :cart_id

      t.timestamps
    end
    add_index :cart_products, :product_id
    add_index :cart_products, :cart_id
  end
end
