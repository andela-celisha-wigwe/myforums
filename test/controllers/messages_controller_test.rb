require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  @@headers = {"Authorization" => "Token augustine-roy-session"}

  setup do
    @@subforum = Subforum.new
    @@subforum.name = Time.now.to_i.to_s[0..14]
    @@subforum.description = "SubDesc"
    assert @@subforum.save

    @@post = @@subforum.posts.new
    @@post.title = "PostTitle"
    @@post.body = "Post body"
    assert @@post.save

    @@message = @@post.messages.new
    @@message.body = "A random body"
    assert @@message.save

    @@url = "/posts/#{@@post.id}/message"
  end
  
  test "list action works as expected" do
    get @@url
    assert_generates @@url, {:controller => "messages", :action => "list", :post => @@post.id }
    assert_response :success 
    assert JSON.parse(@response.body).count == 1
    assert_equal JSON.parse(@response.body).count, 1
  end

  test "show action works as expected" do
    url = @@url + "/" + @@message.id
    get url
    assert_generates url, { :controller => "messages", :action => "show", :id => @@message.id, :post => @@post.id }
    assert_response :success 
  end

  test "create method works as expected" do
  	post @@url, {:body => "This is a new message body"}, @@headers
  	assert_generates @@url, { :controller => "messages", :action => "create", :post => @@post.id }
  	assert_response :success
    assert @@post.messages.count == 2
  end

  test "update method works as expected" do
    url = @@url + "/" + @@message.id
  	put url, {:body => "This is the upated body"}, @@headers
    assert_generates url, { :controller => "messages", :action => "update", :id => @@message.id, :post => @@post.id }
  	assert_response :success
    assert Message.find(@@message.id).body == "This is the upated body"
  end

  test "delete method works as expected" do
    url = @@url + "/" + @@message.id
  	delete url, headers: @@headers
    assert_generates url, { :controller => "messages", :action => "delete", :id => @@message.id, :post => @@post.id }
  	assert_response :success
    assert Message.where(_id: @@message.id).count == 0
  end

  teardown do
    @@subforum.delete
    @@post.delete
    @@message.delete
  end
end
