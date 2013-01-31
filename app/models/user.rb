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
#  remember_token  :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, 
									:password_confirmation

	has_secure_password
	has_many :memberships, dependent: :destroy
	has_many :houses, through: :memberships, source: :house

	before_save do |user| 
		user.email = email.downcase
		user.first_name = user.first_name.titleize
		user.last_name = user.last_name.titleize
	end
	
	before_save :create_remember_token

	validates :first_name, presence: true, length: { maximum: 25 }
	validates :last_name,  presence: true, length: { maximum: 25 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,			 presence: true, 
												 format: { with: VALID_EMAIL_REGEX },
												 uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	validates :password_confirmation, length: { minimum: 6 }

	def add_house!(house)
		memberships.create!(house_id: house.id)
	end

	def in_house?(house)
		memberships.find_by_house_id(house.id)
	end

	def remove_house!(house)
		memberships.find_by_house_id(house.id).destroy
	end

	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
