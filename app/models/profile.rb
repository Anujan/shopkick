class Profile < ActiveRecord::Base
  attr_accessible :address, :country, :first_name, :last_name, :postal_code, :state

  def full_name
    "#{first_name} #{last_name}"
  end
end
