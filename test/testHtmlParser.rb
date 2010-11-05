require 'rubygems'
require 'open-uri'
require 'pp'
require 'hpricot'
require 'uri'
require 'nokogiri'

url = "http://www.last.fm/"
html = open(url)    
document = Hpricot(html)
puts document
