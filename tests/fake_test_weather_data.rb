require_relative '../config/environment'

# The purpose of this class is to have a fake set of weather data to use for debugging purposes.
# If the code isn't working for some reason, I can use the following:
#      class FakeTestWeatherData
#      class DataRequester
#      -   request_of_fake_data_for_a_particular_hour_in_time(timeslot)
# This workflow will allow me to bring in fake weather data that is not being scrapped from the internet.
# in this way, if the code is broken but the scraping portion is not, I can figure that out by First
# running the scraper tests, then running this fake data; if both work properly, then the scraping porion
# of the code is working just fine.

# If the URL changes its class names and the scraping portion is broken, I can run the rest of the program
# with this fake data to make sure it's all working properly.

class FakeTestWeatherData
  def time
    ["12:00 am", "1:00 pm", "2:00 pm", "3:00 pm","4:00 pm", "5:00 pm","6:00 pm", "7:00 pm",]
  end

  def rain
    [95, 72, 30, 15, 0, 45, 53, 70]
  end

  def temperature
    [-20, 29, 42, 68, 73, 77, 85, 97]
  end

  def cloud
    ["Mostly Sunny", "Partly Cloudy", "Clear", "Clear", "Clear", "Mostly Sunny", "Mostly Sunny", "Mostly Sunny"]
  end

  def wind
    [34, 25, 50, 3, 2, 2, 5, 45]
  end
end
