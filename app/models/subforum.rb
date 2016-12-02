class Subforum
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String
	field :description, type: String

	validates :name, length: {maximum:15, minimum:5}
	validates_presence_of :name, :description
	validates_uniqueness_of :name

	# threads and posts.
end