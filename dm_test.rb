require 'data_mapper'
require 'dm-migrations'

DataMapper.setup(:default, 'sqlite3:db.sqlite3')

# Define models
class Post
  include DataMapper::Resource
  has n, :comments
  has n, :categorizations
  has n, :categories, :through => :categorizations

  property :id, Serial           # An auto-increment integer key
  property :title, String        # A varchar type string, for short strings
  property :body, Text           # A text block, for longer string data.
  property :created_at, DateTime # A DateTime, for any date you might like.
end

class Comment
  include DataMapper::Resource
  belongs_to :post

  property :id, Serial
  property :posted_by, String
  property :email, String
  property :url, String
  property :body, Text
end

class Category
  include DataMapper::Resource
  has n, :categorizations
  has n, :posts, :through => :categorizations

  property :id, Serial
  property :name, String
end

class Categorization
  include DataMapper::Resource

  property :id, Serial
  property :created_at, DateTime

  belongs_to :category
  belongs_to :post
end

DataMapper.finalize
