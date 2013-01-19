# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, 
									:password_confirmation

	has_secure_password

	before_save do |user| 
		user.email = email.downcase
		user.first_name = user.first_name.titleize
		user.last_name = user.last_name.titleize
	end

	validates :first_name, presence: true, length: { maximum: 25 }
	validates :last_name,  presence: true, length: { maximum: 25 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,			 presence: true, 
												 format: { with: VALID_EMAIL_REGEX },
												 uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	validates :password_confirmation, length: { minimum: 6 }
end
