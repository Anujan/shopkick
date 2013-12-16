class Order < ActiveRecord::Base
  FULFILLMENT_STATUSES = %w(Not\ fulfilled In\ Process Fulfilled)
  PAYMENT_STATUSES = %w(Unpaid Pending Paid)

  attr_accessible :customer_id, :fulfillment_status, :payment_status, :price, :product_ids
  validates :customer, :price, presence: true
  validates :price, numericality: true

  belongs_to :customer, inverse_of: :orders

  has_many :order_products
  has_many :products, through: :order_products, source: :product

  has_many :order_promotions
  has_one :promotions, through: :order_promotions, source: :promotion

  def as_json(options)
    options.merge!(include: [:customer,
      products: {
        include: {
          images: {
            methods: [:big, :medium, :thumb]
        }
      }
    }])
    super(options)
  end
end
