class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  TOKEN = "augustine-roy-session"

  before_action :cors_preflight_check, :authenticate
  after_action :cors_set_access_control_headers

  @current_user = nil

  protected

	# For all responses in this controller, return the CORS access control headers.
	def cors_set_access_control_headers
		# headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Origin'] = 'http://0.0.0.0:9000'
    headers['Access-Control-Allow-Credentials'] = 'true'
		headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
		headers['Access-Control-Allow-Headers'] = '*'
		headers['Access-Control-Max-Age'] = "1728000"
	end

	# If this is a preflight OPTIONS request, then short-circuit the
	# request, return only the necessary headers and return an empty
	# text/plain.
	def cors_preflight_check
		if request.method == "OPTIONS"
      headers['Access-Control-Allow-Origin'] = 'http://localhost:8080'
      headers['Access-Control-Allow-Credentials'] = 'true'
      headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
      render :json => {}, :content_type => 'application/json'
		end
	end

  def authenticate
    return true if (request.method == "OPTIONS")
    puts request.method
    puts "   : request method"
    authenticate_or_request_with_http_token do |token|
      @current_user = User.find_by(auth_token: token)
      @current_user
    end
  end
end
