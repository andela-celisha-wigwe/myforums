require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  @@headers = {"Authorization" => "Token augustine-roy-session"}

  setup do
    @@subforum = Subforum.new
    @@subforum.name = Time.now.to_i.to_s[0..14]
    @@subforum.description = "This is just a random description"
    assert @@subforum.save
    
    @@url = "/subforums/#{@@subforum.id}/post"
    @@post = @@subforum.posts.new
    @@post.title = "New Post title"
    @@post.body = "New Post content"
    assert @@post.save

  end
  
  test "list action works as expected" do
    get @@url
    assert_generates @@url, {:controller => "posts", :action => "list", :subforum => @@subforum.id }
    assert_response :success
    assert JSON.parse(@response.body).count == 1
  end

  test "show action works as expected" do
    get @@url + "/" + @@post.id
    assert_generates @@url + "/" + @@post.id, { :controller => "posts", :action => "show", :id => @@post.id, :subforum => @@subforum.id }
    assert_response :success 
  end

  test "create method works as expected" do
  	post @@url, { :title => "Post title", :body => "New body" }, @@headers
  	assert_generates @@url, { :controller => "posts", :action => "create", :subforum => @@subforum.id }
  	assert_response :success
    assert Post.find(JSON.parse(@response.body)["_id"]["$oid"]).delete
  end

  test "update method works as expected" do
  	put @@url + "/" + @@post.id, { :title => "Post Updated title", :body => "Updated body" }, @@headers
    assert_generates @@url + "/" + @@post.id, { :controller => "posts", :action => "update", :id => @@post.id, :subforum => @@subforum.id }
  	assert_response :success
    assert Post.find(@@post.id).title == "Post Updated title"
  end

  test "delete method works as expected" do
  	delete @@url + "/" + @@post.id, headers: @@headers
    assert_generates @@url + "/" + @@post.id, { :controller => "posts", :action => "delete", :id => @@post.id, :subforum => @@subforum.id }
  	assert_response :success
    assert Post.where(_id: @@post.id).count == 0
  end

  teardown do
    assert @@subforum.delete
    assert @@post.delete
  end
end
