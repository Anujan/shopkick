class AddOldPriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :old_price, :integer
  end
end
