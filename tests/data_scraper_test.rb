require_relative '../config/environment'
# The purpose of the "DataScraper-class" test is to debug the actual DataScraper class that will be built.
# This version is simpler and does not use the "eval" method that is used on the actual DataScraper class.
# The weather_scraper_1 method is designed to refactor the process of scraping so each weather component
# (clouds, rain, temperature, and wind) will be passed into it vis-a-vis a dependency injection.

# There is no iteration over all the different weather hour indicies on the URL, the index you want to scrape
# is specified on the actual test below.  The problem here is that I cannot "gsub" out the percentage & degree markers;
# I need to do that so I can get temperature, windspeed, and chance of rain all as plain integers so I can then
# go ahead and do some actual math on them.
class DataScraper

  def weather_scraper_1(timeslot, html_class)
    index = timeslot.to_i
    html = open("https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
    list = Nokogiri::HTML(html)
    list.css(html_class).collect {|item| item.text}[index]
  end

  def weather_scraper_2
    # if you want to add data not available on weather.com such as UV index; put that here.
  end
end

def request_time(timeslot)
  temp = DataScraper.new
  temp.weather_scraper_1(timeslot, ".hourly-time .dsx-date")
end

def request_temperature(timeslot)
  temp2 = DataScraper.new
  temp2.weather_scraper_1(timeslot, ".feels span")
end
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# TESTS BEGIN HERE:
puts request_time("0")
puts request_temperature("0")
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
# //////////////////////////////////////////////////
