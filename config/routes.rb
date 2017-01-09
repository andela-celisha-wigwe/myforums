Rails.application.routes.draw do
	
	scope '/subforums' do
		get '/' => 'subforums#list'
		match '/' => 'subforums#list', via: :options
		get '/:id' => 'subforums#show'
		match '/:id' => 'subforums#show', via: :options
		post '/' => 'subforums#create'
		put '/:id' => 'subforums#update'
		delete '/:id' => 'subforums#delete'
	end

	scope '/subforums/:subforum/posts' do
		get '/' => 'posts#list'
		match '/' => 'posts#list', via: :options
		get '/:id' => 'posts#show'
		match '/:id' => 'posts#show', via: :options
		post '/' => 'posts#create'
		put '/:id' => 'posts#update'
		delete '/:id' => 'posts#delete'
	end

	scope '/posts/:post/messages' do
		get '/' => 'messages#list'
		match '/' => 'messages#list', via: :options
		get '/:id' => 'messages#show'
		match '/:id' => 'messages#show', via: :options
		post '/' => 'messages#create'
		put '/:id' => 'messages#update'
		delete '/:id' => 'messages#delete'
	end

	match "/login", as: "login_user", to: "users#auth", via: [:options, :post]
	match "/register", as: "create_user", to: "users#create", via: [:options, :post]

	# scope '/register' do
	# 	match '/' => 'users#create', via: :post #[:options, :post]
	# 	post '/' => 'users#create',
	# end

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
