class Customer < ActiveRecord::Base
  attr_accessible :address_city, :address_country, :address_postal_code,
    :address_street, :address_state, :email_address, :first_name, :last_name,
    :notes, :phone_number, :stripe_id

  validates :address_city, :address_country, :address_postal_code, :address_state,
    :address_street, :email_address, :first_name, :last_name, presence: true

  has_many :orders, inverse_of: :customer, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_or_create(values)
    search_by = [:first_name, :last_name, :address_street]
    where_values = {}.tap do |search|
      search_by.each do |key|
        search[key] = values[key]
      end
    end

    customers = self.where(where_values)
    customer = customers.first

    return customer if customer

    Customer.new(values)
  end
end
