require 'securerandom'

class User
  include Mongoid::Document
  include ActiveModel::SecurePassword
  include Mongoid::Timestamps

  field :username, type: String
  field :auth_token, type: String
  field :password_digest, type: String

  validates_length_of :username, :minimum => 8
  validates_presence_of :username
  # validates_uniqueness_of :username
  validates_presence_of :password

  has_secure_password

  before_save :set_auth_token
  # before_create :set_auth_token

  private

  def set_auth_token
    puts "   auth_token"
  	return self.auth_token if self.auth_token.present?
  	self.auth_token = SecureRandom.uuid.gsub(/\-/, '')
  	# self.save
  	return self.auth_token
  end

end