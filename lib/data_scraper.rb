require_relative '../config/environment'

# OK so this is more complicated than the "data_scraper_test" in the test suite.
# The fundemental difference is the introduction of this "eval" method below.
# The "eval" method is utilized so I can pass the "custom_gsub" value in as a parameter.
# So far all we've learned at Flatiron School is how to pass strings, arrays, integers, and hashes
# around as method parameters; but passing in a method is more complicated and requires this "eval" method.
# Paul S. Says you shouldn't get in the habbit of using "eval" because it creates
# security holes in the program by allowing the user to (possibly) pass any value
# in as the executable code.

# The proper way to do this is to use a "Yield-block" which I should make at some
# point in the refactoring process after the whole program is working properly in the IDE.

# The data scraper is designed to only scrape once; it can scrake temeperature, wind, rain, or time
# depending on which dimension of weather is entered into its parameters.
# later on in the code's workflow, the "time_of_the_day_analysed" method will be introduced and it will
# iterate over the weather_scraper_1 method and run it for each hour of time the user wants to look at...
# ...it does this by using the "request_data_for_a_particular_hour_in_time" method to use the weather_scraper_1
# method FIVE SEPERATE TIMES IN PARALLEL; each of the five times is a different dimension of weather.
class DataScraper                                                                  #https://weather.com/weather/hourbyhour/l/USCO0038:1:US
  def weather_scraper_1(index = nil, targeted_html = nil, custom_gsub = nil, url = "https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
    html = open(url)
    item = Nokogiri::HTML(html)
    eval("item.css(targeted_html)[index.to_i].text#{custom_gsub}")
  end

  def weather_scraper_2
    # if you want to add data not available on weather.com such as UV index; put that here.
  end
end
