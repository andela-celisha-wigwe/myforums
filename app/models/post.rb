class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :body, type: String

  validates :title, presence: true
  validates_presence_of :title, :body

  belongs_to :subforum
  has_many :messages
end
