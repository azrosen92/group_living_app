# == Schema Information
#
# Table name: houses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  admin_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class House < ActiveRecord::Base
  attr_accessible :name, :admin_id
	validates :admin_id, presence: true
	validates :name, presence: true, 
									 uniqueness: { case_sensitive: false }

	has_many :memberships, dependent: :destroy
	has_many :members, through: :memberships, source: :user

	before_save { |house| house.name = name.downcase }

	def add_user!(user)
		memberships.create!(user_id: user.id)
	end

	def have_user?(user)
		memberships.find_by_user_id(user.id)
	end

	def remove_user!(user)
		memberships.find_by_user_id(user.id).destroy
	end
end
