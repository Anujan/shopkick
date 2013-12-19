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

  def self.from_cart(cart, customer)
    order = Order.new
    order.customer = customer
    cart.cart_products.each do |cart_product|
      order.order_products.new(product_id: cart_product.product_id, quantity: cart_product.quantity)
    end
    order.payment_status = 'Pending'
    order.price = cart.total_price

    order
  end

  def charge!
    charge = Stripe::Charge.create(
      :customer    => self.customer.stripe_id,
      :amount      => (self.price * 100).to_i,
      :description => self.products.pluck(:title).join(", "),
      :currency    => 'usd'
    )
    self.payment_status = 'Paid'
    self.save
  end

  def as_json(options)
    options = options.merge(include: [:customer,
      products: {
        include: {
          images: {
            methods: [:big, :medium, :thumb]
        }
      }
    }])

    options = options.to_h if options.respond_to?(:to_h)

    super(options)
  end
end
