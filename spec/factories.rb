FactoryGirl.define do
	factory :user do
		first_name "Aaron"
		last_name "Rosen"
		email "aaron@example.com"
		password "foobar"
		password_confirmation "foobar"
	end

	factory :house do
		name "example house"
		admin_id 1
	end
end
