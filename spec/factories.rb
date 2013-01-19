FactoryGirl.define do
	factory :user do
		first_name "Aaron"
		last_name "Rosen"
		email "aaron@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
end
