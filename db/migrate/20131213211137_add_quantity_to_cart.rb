class AddQuantityToCart < ActiveRecord::Migration
  def change
    add_column :cart_products, :quantity, :integer, default: 1
  end
end
