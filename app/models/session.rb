class Session < ActiveRecord::Base

  belongs_to :user
  
  before_create :generate_token 
  before_create :expiration

  private

  def generate_token
    self.token = SecureRandom.uuid
  end

  def expiration
    self.expires_at = Time.now + 10.minutes
  end
end
