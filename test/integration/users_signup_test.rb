require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	# test for invalid submission
	test "invalid signup information" do
		get signup_path
		assert_no_difference 'User.count', 1 do
			post users_path, params: {user: { name:  "",
	   	                                  email: "user@invalid",
	   	                                  password:              "foo",
	    	                                  password_confirmation: "bar" } }
		end
   	assert_template 'users/new'
		#test for the error messages
   	assert_select 'div#error_explanation'
   	assert_select 'div.alert'
	end
	# test for valid submission
	test "valid signup information" do
		get signup_path
		assert_difference 'User.count', 1 do
			post users_path, params: { user: { name:  "Example User",
			                                   email: "user@example.com",
			                                   password:              "password",
			                                   password_confirmation: "password" } }
		end
		follow_redirect!
		assert_template 'users/show'
   	assert_not flash.empty? #test if flash isn’t empty
		assert is_logged_in?
	end
end
