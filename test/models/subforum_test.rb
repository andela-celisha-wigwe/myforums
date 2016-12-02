require 'test_helper'
require 'subforum'

class SubforumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "It fails on missing values" do
  	subforum = Subforum.new
  	assert_not subforum.save
  end

  test "It successfully saves when values are provided" do
  	subforum = Subforum.new
  	subforum.name = "Test Name"
  	subforum.description = "Test name\'s description."
  	assert subforum.save
  	assert subforum.delete
  end

  test "the subforum name should be unique" do
  	subforum_one = Subforum.new
  	subforum_one.name = "unique"
  	subforum_one.description = "One description."

  	subforum_two = Subforum.new
  	subforum_two.name = "unique"
  	subforum_two.description = "Two description."

  	assert subforum_one.save
  	assert_not subforum_two.save
  	assert subforum_one.delete
  end

  test "subforum has the allowed length" do
  	subforum = Subforum.new
    subforum.description = "This is a description"
    
    subforum.name = "a"
    assert_not subforum.save
    
    subforum.name = "a" * 20
    assert_not subforum.save
    
    subforum.name = "a" * 10
    assert subforum.save
    
    assert subforum.delete

  end
end
