require_relative '../config/environment'

# you don't need this if you have the require_all 'lib' line on the environment
# and you have the bundler gem properly installed.  This is here so I can learn how
# to use require statements in lieu of the bundler gem, in case for some reason I'm
# not using it.
require_relative 'modules'

class WeatherParameters
  attr_accessor :hot_parameter, :cold_parameter, :rain_parameter, :wind_parameter
  include ProblematicWeatherDefined
  include CheckForProblematicWeather
  @@all = []

  def self.delete_all
    @@all = []
  end

  def use_default_parameters
    self.hot_parameter = 80
    self.cold_parameter = 60
    self.rain_parameter = 20
    self.wind_parameter = 18
  end

  def use_user_defined_parameters(hot_parameter, cold_parameter, rain_parameter, wind_parameter)
    self.hot_parameter = hot_parameter
    self.cold_parameter = cold_parameter
    self.rain_parameter = rain_parameter
    self.wind_parameter = wind_parameter
  end
end
