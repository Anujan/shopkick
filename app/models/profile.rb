class Profile < ActiveRecord::Base
  attr_accessible :address_street, :address_country, :first_name, :last_name, :address_postal_code, :address_state, :address_city

  def full_name
    "#{first_name} #{last_name}"
  end
end
