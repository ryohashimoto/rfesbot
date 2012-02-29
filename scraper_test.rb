# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

class FeedItem
  attr_accessor :title, :link, :description
end

class Scraper
  attr_accessor :url, :xpath, :news_url, :items, :titles, :descriptions, :post_text

  def initialize
    @url = "http://www.summersonic.com/2011/"
    @xpath = '//*[@id="blockNews"]/table/tr'
    @news_url = "http://www.summersonic.com/2011/news/"
    @titles = []
    @descriptions = []
  end

  def run
#   doc = Nokogiri::HTML(open(@url))

#    contents = []
#    links = doc.xpath(@xpath).xpath("td/a").map do |link|
#      link['href']
#    end
#     doc.xpath(@xpath).each_with_index do |node|
#       contents << node.xpath("td").text
#     end
#     puts contents.inspect
#     puts links.inspect

#     regexp_link = Regexp.new("^news/index.html#(.*)")
#     link_numstrs = []
#     links.each do |link|
#       if regexp_link.match(link)
#         link_numstrs << $1
#       end
#     end
#     puts "link_numstrs #{link_numstrs.inspect}"

    news_doc = Nokogiri::HTML(open(@news_url))
    xpath = "//*[@id=\"main\"]"
    news_doc.xpath(xpath).xpath("div/h2").first(10).each do |node|
      @titles << node.text
    end
    news_doc.xpath(xpath).xpath("*[@class=\"entryBody clearfix\"]").first(10).each do |node|
      @descriptions << node.text.gsub(/\r\n/, "")
    end

    for i in 0..9
      str = "[Summer Sonic] #{@titles[i]} #{@descriptions[i]}"
      puts str[0..138] + "…"
      puts ""
    end
  end
end

scraper = Scraper.new
scraper.run
