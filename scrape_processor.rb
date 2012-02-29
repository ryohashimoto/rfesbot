load 'festival_scraper.rb'

class ScrapeProcessor
  attr_accessor :festivals, :scrapers, :in_json
  def initialize
    @in_json = "festivals.json"
    @festivals = JSON.parse(File.open(@in_json).read)
    @scrapers = @festivals.map { |festival| FestivalScraper.new(:festival => festival) }
  end
  
  def run
    @scrapers.each do |scraper|
      scraper.run
    end
  end
end
