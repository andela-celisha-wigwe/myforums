require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

	setup do
		@@headers = {
			"Accept" => "application/json",
			"Content-Type" => "application/json"
		}
		@@url = '/register'
	end

	test "can create a new user" do
		post @@url, {username: "elchroyz", password: "royality", password_confirmation: "royality"}#, headers: @@headers
		assert_generates @@url, { :controller => "users", :action => "create" }
		puts @response.body
		assert_response :success
		assert User.find(JSON.parse(@response.body)["_id"]["$oid"]).delete
	end
end
