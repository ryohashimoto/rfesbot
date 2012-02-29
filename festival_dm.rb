require 'data_mapper'

class Festival
  include DataMapper::Resource
  has n, :entries

  property :id, Serial
  property :name, String
  property :abbrev, String
  property :path_name, String
  property :created_at, DateTime
  property :updated_at, DateTime
end

class FestivalRSS < Festival
  property :feed_url, String
end

class FestvalNoRSS < Festival
  property :news_url, String
  property :xpath, String
  property :title_elem, String
  property :data_elem, String
  property :desc_elem, String
end

class Entry
  include DataMapper::Resource
  belongs_to :festival

  property :id, Serial
  property :title, String
  property :description, Text
  property :created_at, DateTime
end
