require_relative '../config/environment'

class DataRequester

  # This method will use the DataScraper class (via the weather_scraper_1 method) to grab each dimension
  # of weather (rain, temp, etc.) from a SINGLE hour in time...that is all.  The process of iterating over
  # a series of hours is done in the CheckWeather class.
  def request_data_for_a_particular_hour_in_time(timeslot)
    data = DataScraper.new
    info = WeatherDatabase.new
    puts info.time = data.weather_scraper_1(timeslot, ".hourly-time .dsx-date")
    puts info.rain = data.weather_scraper_1(timeslot, ".precip div", ".gsub('%', '').to_i")
    puts info.temperature = data.weather_scraper_1(timeslot, ".feels span", ".gsub('°', '').to_i")
    puts info.cloud = data.weather_scraper_1(timeslot, ".hidden-cell-sm")
    puts info.wind = data.weather_scraper_1(timeslot, ".wind", ".gsub(/[a-zA-Z]/, '').to_i")
  end

# The purpose of this alternative method is to utilize the "fake_weather_test_data" should the actual
# scraper break for some reason...this way I can verify the rest of the program is running and isolate
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
