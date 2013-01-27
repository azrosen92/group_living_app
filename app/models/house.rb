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

	before_save { |house| house.name = name.downcase }
end
