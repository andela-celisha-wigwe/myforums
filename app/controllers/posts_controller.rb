class PostsController < ApplicationController

	before_action :authenticate, except: [:show, :list]

	def list
		render json: {}
	end

	def show
		render json: {}
	end

	def create
		render json: {}
	end

	def update
		render json: {}
	end

	def delete
		render json: {}
	end

end
