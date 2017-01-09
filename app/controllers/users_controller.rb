class UsersController < ApplicationController
	before_action :authenticate, except: [:create, :auth]

	def auth
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			render json: user
		else
			render status: 403, json: {:error => "Invalid username of password"}
		end
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: user
		else
			render json: user.errors.full_messages, status: 400
			# render json: {:error => "Username already taken"}, status: 400
		end
	end

	private 

	def user_params
		params.permit :username, :password, :password_confirmation
	end
end
