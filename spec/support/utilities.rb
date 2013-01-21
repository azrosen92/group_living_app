include ApplicationHelper

def full_title(page_title)
	base_title = "Group Living App"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end

def valid_signin(user)
	fill_in "Email", with: user.email
	fill_in "Password", with: user.password
	click_button "Sign in"
end
