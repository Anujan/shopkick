class Product < ActiveRecord::Base
  attr_accessible :barcode, :description, :price, :sku, :title, :category, :category_id,
    :vendor, :visible, :images_attributes, :old_price
  validates :title, :category, :price, :images, presence: true

  has_many :order_products
  has_many :orders, through: :order_products, source: :order

  has_many :images, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :images

  has_many :cart_products, inverse_of: :product, dependent: :destroy
  has_many :carts, through: :cart

  belongs_to :category

  extend FriendlyId
  friendly_id :title, :use => :slugged
end
