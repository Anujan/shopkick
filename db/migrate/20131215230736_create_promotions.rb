class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :code, null: false
      t.string :option, null: false
      t.integer :amount, null: false
      t.string :applies_to, null: false
      t.string :applies_to_arg
      t.date :start_date, null: false
      t.date :end_date
      t.integer :limit
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end
    add_index :promotions, :code, unique: true
  end
end
