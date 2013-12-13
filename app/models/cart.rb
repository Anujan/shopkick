class Cart < ActiveRecord::Base
  attr_accessible :last_accessed

  has_many :cart_products, inverse_of: :cart
  has_many :products, through: :cart_products

  def total_price
    products.sum(:price)
  end

end
