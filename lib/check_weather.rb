require_relative '../config/environment'
require_relative 'modules'
require_relative 'data_requester'

class CheckWeather
  include DataQuery
  def time_of_the_day_analysed(first_hour, last_hour)
    first = first_hour.to_i
    second = last_hour.to_i
    while first < second
      dataset = DataRequester.new
      dataset.request_data_for_a_particular_hour_in_time(first)

#     Utilize this alternate code if the program breaks; this will help isolate the problem because
#     if the program works with this alternate code, that means the scraping process itself it broken
#     and everything upstream is OK.  Depending on permissons, you may need to move the
#     fake_test_weather_data.rb into the 'lib' directory.

#     dataset.request_of_fake_data_for_a_particular_hour_in_time(first) #=> Keep this here for testing purposes
      first += 1
    end
  end
end
