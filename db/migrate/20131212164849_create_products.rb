class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :type, null: false
      t.string :vendor
      t.decimal :price, null: false, precision: 8, scale: 2
      t.string :sku
      t.string :barcode
      t.boolean :visible, default: true

      t.timestamps
    end
  end
end
