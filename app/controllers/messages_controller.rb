class MessagesController < ApplicationController

	before_action :authenticate, except: [:show, :list]

	def list
		render json: Post.find(params[:post]).messages.all
	end

	def show
		render json: Post.find(params[:post]).messages.find(params[:id])
	end

	def create
		post = Post.find(params[:post])
		message = post.messages.create message_params(params)
		if message.save
			render json: message
		else
			render json: {:error => "There was an error"}, status: 400
		end
	end

	def update
		message = Post.find(params[:post]).messages.find(params[:id])
		if message.update message_params(params)
			render json: message
		else
			render json: {:error => "There was an error"}, status: 400
		end
	end

	def delete
		message = Post.find(params[:post]).messages.find(params[:id])
		if message.delete
			render json: {}, status: 204
		else
			render json: {:error => "There was an error"}, status: 400
		end
	end

	private 

	def message_params(params)
		{
			:body => params[:body]
		}
	end

end
