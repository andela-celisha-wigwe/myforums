require 'test_helper'

class SubforumsControllerTest < ActionDispatch::IntegrationTest

  @@headers = {"Authorization" => "Token augustine-roy-session"}
  @@url = '/subforums'
  
  test "list action works as expected" do
    get @@url
     assert_generates @@url, { :controller => "subforums", :action => "list"}
     assert_response :success 
  end

  test "create method works as expected" do
    subforum_name = Time.now.to_i.to_s[0..14]
    post @@url, { :name => subforum_name, :description => "New Description" }, @@headers
    assert_generates @@url, { :controller => "subforums", :action => "create"}
    assert_response :success
    assert Subforum.find(JSON.parse(@response.body)["_id"]["$oid"]).delete
  end

  test "show action works as expected" do
    subforum = Subforum.new
    subforum.name = Time.now.to_i.to_s[0..14]
    subforum.description = "This is just a random description"
    assert subforum.save

    url = @@url + "/#{subforum.id}"
    get url
    assert_generates url, { :controller => "subforums", :action => "show", :id => subforum.id }
    assert_response :success 
    assert subforum.delete
  end

  test "update method works as expected" do
    subforum = Subforum.new
    subforum_name = Time.now.to_i.to_s[0..14]
    subforum.name = subforum_name
    subforum.description = "This is just a random description"
    assert subforum.save

    url = @@url + "/#{subforum.id}"
  	put url, {:name => subforum_name, :description => "New Description Updated" }, @@headers
    assert_generates url, { :controller => "subforums", :action => "update", :id => subforum.id }
  	assert_response :success
    assert Subforum.find(subforum.id).description == "New Description Updated"
    assert subforum.delete
  end

  test "delete method works as expected" do
    subforum = Subforum.new
    subforum.name = 'name'
    subforum.description = 'description'
    subforum.save

  	delete @@url + "/#{subforum.id}", headers: @@headers
    assert_generates @@url + "/1", { :controller => "subforums", :action => "delete", :id => "1" }
  	assert_response :success
    assert Subforum.where(_id: subforum.id).count == 0
  end
end
