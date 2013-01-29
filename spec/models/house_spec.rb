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

require 'spec_helper'

describe "House" do
	let(:user) { FactoryGirl.create(:user) }
	before do
		@house = House.new(name: "Example House", admin_id: user.id)
	end

	subject { @house }

	it { should respond_to(:name) }
	it { should respond_to(:admin_id) }
	it { should respond_to(:memberships) }
	it { should respond_to(:members) }
	
	it { should be_valid }

	describe "when admin_id is not present" do
		before { @house.admin_id = nil }
		it { should_not be_valid }
	end

	describe "when name is not present" do
		before { @house.name = nil }
		it { should_not be_valid }
	end

	describe "when house name is already taken" do
		before do
			house_with_same_name = @house.dup
			house_with_same_name.name = @house.name.upcase
			house_with_same_name.save
		end

		it { should_not be_valid }
	end

end
