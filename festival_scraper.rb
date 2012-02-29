# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

load 'base.rb'
require 'json'

class FestivalScraper < Base
  attr_accessor :festival, :feed_items

  def run
    @feeditems = []
    news_doc = Nokogiri::HTML(open(@festival["news_url"]) )
    news_node = news_doc.xpath(@festival["xpath"])
    # Todo: how to relate title and description
    news_node.xpath(@festival["title_elem"]).first(10).each do |title_node|
      feed_item = {:title => title_node.text}
      @feed_items << feed_item
    end
    news_node.xpath(@festival["desc_elem"]).first(10).each_with_index do |desc_node, i|
      @feed_items[i][:desc] = desc_node.text
    end
  end
  
  def write_feed_items
    out_file = File.open("feeds/#{@festival[:path_name].json}", "w")
    out_file.write(@feed_items.to_json)
    out_file.close
  end
end