class Product < ActiveRecord::Base
  attr_accessible :barcode, :description, :price, :sku, :title, :category, :vendor, :visible

  validates :title, :category, :price, presence: true

  has_many :order_products
  has_many :orders, through: :order_products, source: :order
end
