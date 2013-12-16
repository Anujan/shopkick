class Promotion < ActiveRecord::Base
  attr_accessible :amount, :applies_to, :code, :end_date, :limit, 
  	:option, :start_date, :applies_to_arg

  OPTIONS = %w(dollar percent shipping)
  APPLIES_TO = ['all orders', 'orders over', 'specific product', 'specific category']

  validates :amount, :applies_to, :code, :start_date, :option, presence: true
  validates :option, inclusion: { in: OPTIONS }
  validates :applies_to, inclusion: { in: APPLIES_TO }, unless: :free_shipping?
  validates :applies_to, inclusion: { in: shipping_options }, if: :free_shipping?
  validates :amount, numericality: true
  validates :applies_to_arg, presence: true, if: :has_applies_to_arg?
  validates :code, uniqueness: true

  has_many :order_promotions
  has_many :orders, through: :order_promotions, source: :order

  def applies_to_arg?
  	self.applies_to != 'all orders'
  end

  def expired?
  	!self.enabled? || Date.today < self.start_date || Date.today > self.end_date || order_promotions.count > limit
  end

  def active?
  	!expired?
  end

  def end_date
  	read_attribute(:end_date) || Date.tomorrow
  end

  def limit
  	read_attribute(:limit) || Float::INFINITY
  end

  def free_shipping?
  	self.option == 'shipping'
  end

  def to_s
  	when self.option
  		case 'shipping'
  			"Free shipping for any shipping rate that is less than or equal to #{amount} and applies to #{applies_to}"
			case 'dollar'
				applies_to_str("Take $#{amount} off for #{applies_to} ")
			case 'percent'
				applies_to_str("Take #{amount}% off for #{applies_to} ")
			end
  	end
  end

  def applies_to_str(str='')
  	when applies_to
			case 'orders_over'
				str += "$#{applies_to_arg}"
			case 'specific product'
				str += Product.find(applies_to_arg).title
			case 'specific category'
				str += Category.find(applies_to_arg).title
			end
		end

		str
  end

  def shipping_options
  	defaults = ["All countries"]
  	if Profile.first
  		defaults += [Profile.first.address_country, "Rest of the world"]
  	end

  	defaults
  end
end