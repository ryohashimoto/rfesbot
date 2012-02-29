load 'base.rb'
require 'json'
require 'feed-normalizer'
require 'open-uri'

class RSSFetcher < Base
  attr_accessor :festival
  def run
    puts "#{@festival["name"]}----------------------------------"
    feed = FeedNormalizer::FeedNormalizer.parse open(@festival["feed_url"])
    feed.entries.each do |entry|
      puts "-----"
      puts entry.title
      puts "--"
      puts entry.description.gsub(/<\/?[^>]*>/, "")
    end

  end
  def list_rss_uri
    puts @festival["feed_url"]
  end
end

festivals = JSON.parse(File.open("festivals_rss.json").read)
festivals.each do |festival|
  fetcher = RSSFetcher.new(:festival => festival)
  fetcher.run
end
