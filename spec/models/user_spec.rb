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

require 'spec_helper'

describe User do

	before do 
		@user = User.new(first_name: "Aaron", 
										 last_name:  "Rosen",
										 email: 			"aaron@example.com",
										 password: "foobar",
										 password_confirmation: "foobar") 
	end

	subject { @user }

	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:authenticate) }
	it { should respond_to(:remember_token) }
	it { should respond_to(:memberships) }
	it { should respond_to(:houses) }
	it { should respond_to(:in_house?) }
	it { should respond_to(:add_house!) }
	it { should respond_to(:remove_house!) }

	it { should be_valid }

	describe "when name is not present" do
		before do
			@user.first_name = " "
			@user.last_name = " " 
		end

		it { should_not be_valid }
		
	end

	describe "when name is too long" do
		before do
			@user.first_name = "a"*26 
			@user.last_name = "b"*26
		end

		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }

		it { should_not be_valid }

	end

	describe "when email address is invalid" do
		it " should be invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				@user.should_not be_valid
			end
		end
	end

	describe "when email address is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				@user.should be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end

		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end

	describe "when password does not match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "when the password confirmation is nil" do
		before { @user.password_confirmation = nil }
		it { should_not be_valid }
	end

	describe "with a password that's too short" do
		before { @user.password = @user.password_confirmation = "a"*5 }
		it { should be_invalid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by_email(@user.email) }

		describe "with valid password" do
			it { should_not == found_user.password }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not == user_for_invalid_password }
			specify { user_for_invalid_password.should be_false }
		end
	end

	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
	end

	describe "joining a house" do
		before do
			@user.save
			@house = House.new(name: "test house", admin_id: @user.id)
			@house.save
			@user.add_house!(@house)
		end

		it { should be_in_house(@house) }
		its(:houses) { should include(@house) }

		describe "and leaving a house" do
			before do
				@user.remove_house!(@house)
			end

			it { should_not be_in_house(@house) }
			its(:houses) { should_not include(@house) }
		end
	end

end
