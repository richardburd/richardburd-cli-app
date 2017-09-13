require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative '../config/environment'
# Zenmaster Avi hasn't taught us how to make actual rspec tests yet,
# but he has explained the theory behind test-driven-development (TDD)
# This file is the foundation of the program; it uses the simplest code
# to scrape the weather from the website I'm scraping.

# The idea here is to make sure the "test" at the bottom of the file passes,
# and continues to pass...if www.weather.com changes their html or URL's, then
# this file will produce and error and I'll know I have to go back & re-work the scraping.
# If everything is working correctly, this test should spit out a series of numbers with no
# errors; these numbers are the raw weather data

puts "\nOK so you should see a bunch of integers and times...if the weather.com HTML's structure changed at all, you should see an error message somewhere in here."
puts "\nAlso, look at the times, if the current hour is before the :45 minute mark, the first time shown should be the current hour, if it's currently past the :45 minute mark, the next hour should be the first one shown"
puts "\nYou should see about 12 to 16 hours out into the future, if you have fewer than 12 hours listed, the 'Boulder-WeatherCheck' program will probably break :("

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


# It shure would be nice to do this project with a series of arrays and hashes but the
# instructions on the Learn.co website specifically says not to make a collection of hashes
# and I assume arrays are not so great either...so the weather will need to be modeled as an
# object instead.
def hour_scraper
  html = open("https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
  # alternative URL's with the same info are:
  # https://weather.com/weather/hourbyhour/l/USCO0038:1:US
  # https://weather.com/weather/hourbyhour/l/80302:4:US
  list = Nokogiri::HTML(html)
  array = []
# this will remove the "am" & "pm" markers which we don't need to do now.
# list.css(".hourly-time .dsx-date").collect {|item| array << item.text.gsub("am", "").gsub("pm", "")}
  list.css(".hourly-time .dsx-date").collect {|item| array << item.text}
  array
end

def rain_scraper
  html = open("https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
  list = Nokogiri::HTML(html)
  array = []
  list.css(".precip div").collect {|item| array << item.text.gsub("%", "").to_i}
  array
end

def temperature_scraper
  html = open("https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
  list = Nokogiri::HTML(html)
  array = []
  list.css(".feels span").collect {|item| array << item.text.gsub("°", "").to_i}
  array
end

def wind_scraper
  html = open("https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
  list = Nokogiri::HTML(html)
  array = []
  list.css(".wind").collect {|item| array << item.text.gsub(/[a-zA-Z]/, "").to_i}
  array
end

def cloud_scraper
  html = open("https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
  list = Nokogiri::HTML(html)
  array = []
  list.css(".hidden-cell-sm").collect {|item| array << item.text}
  array
end

# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# TESTS BEGIN HERE:
puts single_hour_scraper
puts hour_scraper
puts rain_scraper
puts temperature_scraper
puts cloud_scraper
puts "\nOK so you should see a bunch of integers and times...if the weather.com HTML's structure changed at all, you should see an error message somewhere in here."
puts "\nAlso, look at the times, if the current hour is before the :45 minute mark, the first time shown should be the current hour, if it's currently past the :45 minute mark, the next hour should be the first one shown"
puts "\nYou should see about 12 to 16 hours out into the future, if you have fewer than 12 hours listed, the 'Boulder-WeatherCheck' program will probably break :("
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
