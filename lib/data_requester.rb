require_relative '../config/environment'
require_relative 'data_scraper'
require_relative 'weather_database'

class DataRequester

  # This method will use the DataScraper class (via the weather_scraper_1 method) to grab each dimension
  # of weather (rain, temp, etc.) from a SINGLE hour in time...that is all.  The process of iterating over
  # a series of hours is done in the CheckWeather class.
  def request_data_for_a_particular_hour_in_time(timeslot)
    data = DataScraper.new

    # OK so this is where the actual weather database is created.
    # Each time this method runs, it creates one instance of the WeatherDatabase class.
    # The <<time_of_the_day_analysed>> method upstream (in the CheckWeather class) is what
    # does the actual iterations; it makes sure that EACH HOUR the user requests to be analyzed
    # actually gets analyzed; this method is only responsible for one hour of time.
    info = WeatherDatabase.new
    info.time = data.weather_scraper_1(timeslot, ".hourly-time .dsx-date")
    info.rain = data.weather_scraper_1(timeslot, ".precip div", ".gsub('%', '').to_i")
    info.temperature = data.weather_scraper_1(timeslot, ".feels span", ".gsub('°', '').to_i")
    info.cloud = data.weather_scraper_1(timeslot, ".hidden-cell-sm")
    info.wind = data.weather_scraper_1(timeslot, ".wind", ".gsub(/[a-zA-Z]/, '').to_i")
    puts "...Grabbing data for the #{info.time} timeblock"
  end

# The purpose of this alternative method is to utilize the "fake_weather_test_data" should the actual
# scraper break for some reason...this way I can verify that the rest of the program is running and isolate
# the scrapper as the problem if it is.

#  def request_of_fake_data_for_a_particular_hour_in_time(timeslot)
#    data = FakeTestWeatherData.new
#    info = WeatherDatabase.new
#    puts info.time = data.time[timeslot.to_i]
#    puts info.rain = data.rain[timeslot.to_i]
#    puts info.temperature = data.temperature[timeslot.to_i]
#    puts info.cloud = data.cloud[timeslot.to_i]
#    puts info.wind = data.wind[timeslot.to_i]
#  end
end
