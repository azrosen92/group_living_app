class Membership < ActiveRecord::Base
  attr_accessible :house_id, :user_id

	belongs_to :user, class_name: "User"
	belongs_to :house, class_name: "House"

	validates :user_id, presence: true
	validates :house_id, presence: true
end
