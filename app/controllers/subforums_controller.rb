class SubforumsController < ApplicationController
	
	before_action :authenticate, except: [:show, :list]

	def list
		render json: Subforum.all
	end

	def show
		render json: Subforum.find(params[:id])
	end

	def create
		subforum = Subforum.new
		subforum.name = params[:name]
		subforum.description = params[:description]
		if subforum.save
			render json: subforum
		else
			puts subforum.to_json
			puts subforum.errors.full_messages
			render json: {:error => "There was an error"}, status: 400
		end
	end

	def update
		subforum = Subforum.find(params[:id])
		subforum.name = params[:name] if params[:name]
		subforum.description = params[:description] if params[:description]
		if subforum.save
			render json: subforum
		else
			puts subforum.to_json
			puts subforum.errors.full_messages
			render json: {:error => "There was an error"}, status: 400
		end
	end

	def delete
		if Subforum.destroy_all(id: params[:id])
			render json: {}, status: 204
		else
			render json: {:error => "There was an error"}, status: 400
		end
	end

end