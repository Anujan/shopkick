class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :price, null: false
      t.string :payment_status, null: false, default: 'Unpaid'
      t.string :fulfillment_status, null: false, default: 'Not Fulfilled'

      t.timestamps
    end

    add_index :orders, :customer_id
  end
end
