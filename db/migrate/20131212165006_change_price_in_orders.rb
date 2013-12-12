class ChangePriceInOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :price
    add_column :orders, :price, :decimal, precision: 8, scale: 2
  end
end
