class Customer < ActiveRecord::Base
  attr_accessible :address_city, :address_country, :address_postal_code,
    :address_street, :address_state, :email_address, :first_name, :last_name,
    :notes, :phone_number

  validates :address_city, :address_country, :address_postal_code, :address_state,
    :address_street, :email_address, :first_name, :last_name, :phone_number, presence: true

  has_many :orders, inverse_of: :customer

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_address
    [address_street, address_city, address_state, address_country].compact.join(', ')
  end
end
