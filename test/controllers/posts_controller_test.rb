require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  @@headers = {"Authorization" => "Token augustine-roy-session"}
  @@url = '/subforums/1/post'
  
  test "list action works as expected" do
    get @@url
    assert_generates @@url, {:controller => "posts", :action => "list", :subforum => "1" }
    assert_response :success 
  end

  test "show action works as expected" do
    get @@url + "/1"
    assert_generates @@url + "/1", { :controller => "posts", :action => "show", :id => "1", :subforum => "1" }
    assert_response :success 
  end

  test "create method works as expected" do
  	post @@url, headers: @@headers
  	assert_generates @@url, { :controller => "posts", :action => "create", :subforum => "1" }
  	assert_response :success
  end

  test "update method works as expected" do
  	put @@url + "/1", headers: @@headers
    assert_generates @@url + "/1", { :controller => "posts", :action => "update", :id => "1", :subforum => "1" }
  	assert_response :success
  end

  test "delete method works as expected" do
  	delete @@url + "/1", headers: @@headers
    assert_generates @@url + "/1", { :controller => "posts", :action => "delete", :id => "1", :subforum => "1" }
  	assert_response :success
  end
end
