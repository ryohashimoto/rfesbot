require 'nokogiri'

if ARGV[0]
  doc = Nokogiri::HTML(open(ARGV[0]))
  puts doc.inspect
  puts Nokogiri::HTML::DocumentFragment.parse(doc).inspect
else
  puts "Usage: ruby html_tidy.rb <html_file>"
  exit(0)
end