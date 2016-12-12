class User < ApplicationRecord
	require "bcrypt"
	before_create :set_encrypt_password

	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }

 	def set_encrypt_password
 		self.password = BCrypt::Password.create self.password
 	end

end
