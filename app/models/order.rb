class Order < ActiveRecord::Base
  attr_accessible :customer_id, :fulfilment_status, :payment_status, :price
  validates :customer, :price, presence: true
  validates :price, numericality: true

  belongs_to :customer, inverse_of: :orders
end
