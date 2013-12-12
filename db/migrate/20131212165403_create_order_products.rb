class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.integer :product_id
      t.integer :order_id

      t.timestamps
    end
    add_index :order_products, :product_id
    add_index :order_products, :order_id
  end
end
