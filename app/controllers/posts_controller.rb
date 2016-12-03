class PostsController < ApplicationController

	before_action :authenticate, except: [:show, :list]

	def list
		render json: Subforum.find(params[:subforum]).posts.all
	end

	def show
		render json: Post.find(params[:id])
	end

	def create
		subforum = Subforum.find(params[:subforum])
		post = subforum.posts.create post_params(params)
		if post.save
			render json: post
		else
			puts post.to_json
			puts post.errors.full_messages
			render json: {:error => "There was an error"}, status: 400
		end
	end

	def update
		subforum = Subforum.find(params[:subforum])
		post = subforum.posts.find(params[:id])

		if post.update post_params(params)
			render json: post
		else
			puts post.to_json
			puts post.errors.full_messages
			render json: {:error => "There was an error"}, status: 400
		end
	end

	def delete
		if Post.destroy_all(id: params[:id])
			render json: {}, status: 204
		else
			render json: {:error => "there was an error"}, status: 400
		end
	end

	private

	def post_params(params)
		{
			:title => params["title"],
			:body => params["body"]
		}
	end

end
