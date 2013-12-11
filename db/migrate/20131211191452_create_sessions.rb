class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :store_id
      t.string :token
      t.string :ip_address
      t.string :user_agent

      t.timestamps
    end
    add_index :sessions, :store_id
    add_index :sessions, :token
  end
end
