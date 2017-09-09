require 'nokogiri'
require 'open-uri'
require 'pry'
require 'rubygems'

class DataScraper

  def weather_scraper_1(html_class)
    html = open("https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
    list = Nokogiri::HTML(html)
    array = []
    list.css(html_class).collect {|item| array << item.text}
    array
  end

  def weather_scraper_2
    # if you want to add data not available on weather.com such as UV index; put that here.
  end
end

def request_time(timeslot)
  temp = DataScraper.new
  temp.weather_scraper_1(".hourly-time .dsx-date")
end
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# TESTS BEGIN HERE:
puts request_time("4")
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
