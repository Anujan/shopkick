class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :product_id

      t.timestamps
    end
    add_index :images, :product_id
  end
end
