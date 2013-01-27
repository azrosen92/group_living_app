require 'spec_helper'

describe "HousePages" do
	subject { page }

	let(:house) { FactoryGirl.create(:house) }

	describe "New house page" do
		before { visit new_house_path }

		it { should have_selector('h1', text: 'Create Your New House') }
		it { should have_selector('title', text: full_title('New House')) }
	end

	describe "House page" do
		before { visit house_path(house) }

		it { should have_selector('h1', text: house.name) }
		it { should have_selector('title', text: full_title(house.name)) }
	end

	describe "creating a new house" do
		let(:submit) { "Create House" }
		before { visit new_house_path }

		describe "with invalid information" do
			it "should not create a house" do
				expect { click_button submit }.not_to change(House, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "House Name", with: "example house"
			end

			it "should create a new house" do
				expect { click_button submit }.to change(House, :count).by(1)
			end
		end
	end
end
