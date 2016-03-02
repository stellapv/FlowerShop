require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt
	has_many :orders
	has_many :comments
  has_one :session

	validates_presence_of :firstname, :lastname, :email, :password_digest
	validates :email, uniqueness: true
	validates :password, presence: true, length: { in: 6..20 }

	has_secure_password

end
