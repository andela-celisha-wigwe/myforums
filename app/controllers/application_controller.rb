class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	TOKEN = "augustine-roy-session"

	skip_before_filter :verify_authenticity_token

	@current_user = nil

	protected

	def authenticate
		# logger = Logger.new(STDOUT) 
		# config.logger = Log4r::Logger.new("Application Log")
		
		# authenticate_or_request_with_http_token do |token, options|
		# 	Rails.logger.info "roy->#{token}"
		# 	ActiveSupport::SecurityUtils.secure_compare(
		# 		::Digest::SHA256.hexdigest(token), # REQUEST IS SENDING THIS TOKEN
		# 		::Digest::SHA256.hexdigest(TOKEN), # CURRENT TOKEN
		# 	)
		# end

		authenticate_or_request_with_http_token do |token|
		  @current_user = User.find_by(auth_token: token)
		  @current_user
		end
	end
end
