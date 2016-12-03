class UsersController < ApplicationController
	def auth
		user = User.find_by(username: params[:username])
		if user.authencate(params[:password])
			render json: user.auth_token
		else
			render status: 403, json: {:error => "There was an error"}
		end
	end

	def create
		user = User.create user_params(params)
		if user.save
			render json: user
		else
			render json: {:error => "Username already taken"}, status: 400
		end
	end

	private 

	def user_params(params)
		{
			:username => params[:username],
			:password => params[:password],
			:password_confirmation => params[:password_confirmation]
		}
	end
end
