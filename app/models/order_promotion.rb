class OrderPromotion < ActiveRecord::Base
  attr_accessible :order_id, :promotion_id

	belongs_to :order, inverse_of: :order_promotions
  belongs_to :promotion, inverse_of: :order_promotions

  validates :order, :promotion, presence: true
end
