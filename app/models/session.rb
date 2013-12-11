class Session < ActiveRecord::Base
  attr_accessible :ip_address, :store_id, :token, :user_agent

  after_initialize :ensure_token!

  validates :ip_address, :store_id, :token, :user_agent, presence: true

  belongs_to :store

  def ensure_token!
    self.token = SecureRandom.urlsafe_base64
  end
end
