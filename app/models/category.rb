class Category < ActiveRecord::Base
  attr_accessible :title
  has_many :products

  extend FriendlyId
  friendly_id :title, :use => :slugged
end
