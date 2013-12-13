class Image < ActiveRecord::Base
  attr_accessible :product_id, :photo

  validates :product, :photo, presence: true

  belongs_to :product, inverse_of: :images

  has_attached_file :photo, styles: {
    big: "480x480#",
    medium: "220x200#",
    thumb: "100x100#"
  }
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
end
