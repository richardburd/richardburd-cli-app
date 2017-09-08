# Zenmaster Avi hasn't taught us how to make actual rspec tests yet,
# but he has explained the theory behind test-driven-development (TDD)
# This file is the foundation of the program; it uses the simplest code
# to scrape the weather from the website I'm scraping.

# The idea here is to make sure the "test" at the bottom of the file passes,
# and continues to pass...if www.weather.com changes their html or URL's, then
# this file will produce and error and I'll know I have to go back & do more work.


require 'nokogiri'
require 'open-uri'
require 'pry'
require 'rubygems'

def single_hour_scraper
  html = open("https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
  list = Nokogiri::HTML(html)
#  list.css(".clickable closed  .dsx-date").text      #[1].text.gsub("°", "").to_i
  list.css(".dsx-date").text
end

# the partial hours:
# div div main div article #twc-scrollabe table tbody tr td div div span.dsx-date
# the main hours:
# div div main div article #twc-scrollabe table tbody tr td div div span.dsx-date

puts single_hour_scraper

# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
