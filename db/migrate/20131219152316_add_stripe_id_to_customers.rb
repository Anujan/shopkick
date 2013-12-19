class AddStripeIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :stripe_id, :string
  end
end
