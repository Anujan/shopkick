class Order < ActiveRecord::Base
  FULFILLMENT_STATUSES = ['Not fulfilled', 'In Process', 'Fulfilled']
  PAYMENT_STATUSES = ['Unpaid', 'Pending', 'Paid']

  attr_accessible :customer_id, :fulfilment_status, :payment_status, :price
  validates :customer, :price, presence: true
  validates :price, numericality: true

  belongs_to :customer, inverse_of: :orders
end
