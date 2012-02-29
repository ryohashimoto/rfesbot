# -*- coding: utf-8 -*-
require 'json'

class Festival
  attr_accessor :name, :news_url, :abbrev, :path_name
end

file = File.open("festivals.json")
json_string = file.read
festivals = JSON.parse(json_string)

fes_arr = []
festivals.each do |festival|
  fes = Festival.new
  fes.name = festival["name"]
  fes.news_url = festival["news_url"]
  fes.abbrev = festival["abbrev"]
  fes.path_name = festival["path_name"]
  fes_arr << fes
end

puts fes_arr.inspect