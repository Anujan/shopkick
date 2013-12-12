require 'bcrypt'

class Store < ActiveRecord::Base
  attr_accessible :email, :name, :password
  attr_reader :password

  validates :name, :email, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :name, :email, :password_digest, presence: true
  validates :name, exclusion: { in: %w(www public admin) }

  has_many :sessions

  after_create :setup_tenant!

  def self.find_by_credentials(email, password)
    store = Store.find_by_email(email)
    store if store && store.is_valid_password?(password)
  end

  def password=(pwd)
    @password = pwd
    self.password_digest = BCrypt::Password.create(pwd)
  end

  private
    def is_valid_password?(pwd)
      BCrypt::Password.new(self.password_digest).is_password?(pwd)
    end

    def setup_tenant!
      Apartment::Database.create(self.name)
      Apartment::Database.switch(self.name)
    end
end
