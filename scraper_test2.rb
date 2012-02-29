# -*- coding: utf-8 -*-
require 'json'
require 'nokogiri'
require 'open-uri'
require 'kconv'

load 'base.rb'

ENTRY_COUNT = 3

class FestivalScraper < Base
  attr_accessor :festival, :feed_items

  def run
    @feed_items = []
    news_doc = Nokogiri::HTML(open(@festival["news_url"]))
    news_node = news_doc.xpath(@festival["xpath"])
    #puts news_node.inspect
    # Todo: how to relate title and description
    if @festival["path_name"] == "world_happiness"
      news_node.xpath(@festival["title_elem"]).first(ENTRY_COUNT).each do |title_node|
        regexp = Regexp.new("^(.*)　(.*)")
        date_title_string = title_node.text.strip
        regexp =~ date_title_string
        feed_item = {:title => $2, :date => $1}
        @feed_items << feed_item
      end
    else
      news_node.xpath(@festival["title_elem"]).first(ENTRY_COUNT).each do |title_node|
        feed_item = {:title => title_node.text.strip}
        @feed_items << feed_item
      end
      news_node.xpath(@festival["date_elem"]).first(ENTRY_COUNT).each_with_index do |date_node,i|
        @feed_items[i][:date] = date_node.text.strip
      end
    end
    if @festival["desc_elem"] == ""
      @festival["desc_elem"] = @festival["title_elem"]
    end
    news_node.xpath(@festival["desc_elem"]).first(ENTRY_COUNT).each_with_index do |desc_node,i|
      @feed_items[i][:desc] = desc_node.text.strip
    end
    puts "#{@festival["name"]}----------------------------------"
    @feed_items.each do |feed_item|
      puts "-----"
      puts feed_item[:title]
      puts "--"
      puts feed_item[:date]
      puts "--"
      puts feed_item[:desc]
    end
  end  
end

festivals = JSON.parse(File.open("festivals.json").read)
festivals.each do |festival|
  scraper = FestivalScraper.new(:festival => festival)
  scraper.run
end


