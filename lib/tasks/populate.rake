namespace :db do
	desc "Erase and fill database"
	task :populate => :environment do
		require 'faker'
		[Subforum, Post, Message].each(&:delete_all)
		# or Rake::Task['db:reset'].invoke
		
		# Create some subforums
		15.times do |n|
			Subforum.create!(
				:name =>  "App_Subforum_#{n}_#{Faker::Hipster.word}"[0..14],
				:description =>  Faker::Hipster.paragraph
			)
		end

		# Create some posts for each subforum
		Subforum.all.each do |subforum|
			25.times do
				subforum.posts.create!(
					:title =>  Faker::Hipster.sentence,
					:body => Faker::Hipster.paragraph(3),
				)
			end
		end

		# Create some messages for each post
		Post.all.each do |post|
			50.times do
				post.messages.create!(
					:body => Faker::Hipster.paragraph,
				)
			end
		end
	end
end