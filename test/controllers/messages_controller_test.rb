require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  @@headers = {"Authorization" => "Token augustine-roy-session"}
  @@url = '/posts/1/message'
  
  test "list action works as expected" do
    get @@url
    assert_generates @@url, {:controller => "messages", :action => "list", :post => "1" }
    assert_response :success 
  end

  test "show action works as expected" do
    get @@url + "/1"
    assert_generates @@url + "/1", { :controller => "messages", :action => "show", :id => "1", :post => "1" }
    assert_response :success 
  end

  test "create method works as expected" do
  	post @@url, headers: @@headers
  	assert_generates @@url, { :controller => "messages", :action => "create", :post => "1" }
  	assert_response :success
  end

  test "update method works as expected" do
  	put @@url + "/1", headers: @@headers
    assert_generates @@url + "/1", { :controller => "messages", :action => "update", :id => "1", :post => "1" }
  	assert_response :success
  end

  test "delete method works as expected" do
  	delete @@url + "/1", headers: @@headers
    assert_generates @@url + "/1", { :controller => "messages", :action => "delete", :id => "1", :post => "1" }
  	assert_response :success
  end
end
