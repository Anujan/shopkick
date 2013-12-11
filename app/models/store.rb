require 'bcrypt'

class Store < ActiveRecord::Base
  attr_accessible :email, :name, :password
  attr_reader :password

  validates :name, :email, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :name, :email, :password_digest, presence: true

  has_many :sessions

  def password=(pwd)
    @password = pwd
    self.password_digest = BCrypt::Password.create(pwd)
  end

  def is_valid_password?(pwd)
    BCrypt::Password.new(self.password_digest).is_password?(pwd)
  end

  def self.find_by_credentials(email, password)
    store = Store.find_by_email(email)
    store if store && store.is_valid_password?(password)
  end
end
