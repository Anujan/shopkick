class CartProduct < ActiveRecord::Base
  attr_accessible :cart, :product, :quantity

  belongs_to :cart, inverse_of: :cart_products
  belongs_to :product, inverse_of: :cart_products

  validates :cart, :product, :quantity, presence: true
  validates :quantity, numericality: true

  def self.find_by_cart_and_product_slug(cart, slug)
    query = <<-SQL
      SELECT cart_products.*, products.title FROM cart_products
      JOIN products ON cart_products.product_id = products.id
      WHERE cart_id = ? AND products.slug = ?
    SQL
    CartProduct.find_by_sql([query, cart, slug])
  end

  def add_quantity
    self.quantity += 1
    save!
  end

  def price
    product.price * quantity
  end
end