class AddCategoryToProducts < ActiveRecord::Migration
  def change
  	remove_column :products, :category
    add_column :products, :category_id, :integer
    add_index :products, :category_id
  end
end
