class ChangeTypeToCategory < ActiveRecord::Migration
  def change
    remove_column :products, :type
    add_column :products, :category, :string
  end
end
