Rails.application.routes.draw do
	
	scope '/subforums' do
		get '/' => 'subforums#list'
		get '/:id' => 'subforums#show'
		post '/' => 'subforums#create'
		put '/:id' => 'subforums#update'
		delete '/:id' => 'subforums#delete'
	end

	scope '/subforums/:subforum/post' do
		get '/' => 'posts#list'
		get '/:id' => 'posts#show'
		post '/' => 'posts#create'
		put '/:id' => 'posts#update'
		delete '/:id' => 'posts#delete'
	end

	scope '/posts/:post/message' do
		get '/' => 'messages#list'
		get '/:id' => 'messages#show'
		post '/' => 'messages#create'
		put '/:id' => 'messages#update'
		delete '/:id' => 'messages#delete'
	end

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end