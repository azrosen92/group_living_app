require 'spec_helper'

describe Membership do

	let(:user) { FactoryGirl.create(:user) }
	let(:house) { FactoryGirl.create(:house) }
	let(:membership) { house.memberships.build(user_id: user.id, 
																						 house_id: house.id) }

	subject { membership }

	it { should be_valid }

	describe "users methods" do
		it { should respond_to(:user) }
		it { should respond_to(:house) }
		its(:user) { should == user }
		its(:house) { should == house }
	end

	describe "when user id is not present" do
		before { membership.user_id = nil }
		it { should_not be_valid }
	end

	describe "when house id is not present" do
		before { membership.house_id = nil }
		it { should_not be_valid }
	end

end
