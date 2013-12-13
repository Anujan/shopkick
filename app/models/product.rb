class Product < ActiveRecord::Base
  attr_accessible :barcode, :description, :price, :sku, :title, :category,
    :vendor, :visible, :images_attributes
  validates :title, :category, :price, :images, presence: true

  has_many :order_products
  has_many :orders, through: :order_products, source: :order

  has_many :images, inverse_of: :product, dependent: :destroy
  accepts_nested_attributes_for :images

  extend FriendlyId
  friendly_id :title, :use => :slugged
end
