class CreateOrderPromotions < ActiveRecord::Migration
  def change
    create_table :order_promotions do |t|
      t.integer :promotion_id
      t.integer :order_id

      t.timestamps
    end
    add_index :order_promotions, :promotion_id
    add_index :order_promotions, :order_id
  end
end
