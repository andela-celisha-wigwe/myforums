require 'securerandom'

class User
  include Mongoid::Document
  include Mongoid::Timestamp

  field :username, type: String
  field :auth_token, type: String

  validate_length_of :username, :minimum => 8
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :password

  has_secure_password

  before_create :set_auth_token

  private

  def set_auth_token
  	return self.auth_token if self.auth_token.present?
  	self.auth_token - SecureRandom.uuid.gsub(/\-/, '')
  	self.save
  	return self.auth_token
  end

end

=begin
	hash passwords
	modify app controller
	fixed token against auth token, returns auth_token,
	
rescue Exception => e
	
end
