require_relative '../config/environment'

module ProblematicWeatherDefined
  def too_hot?(database, parameter)
    database.all.each do |hour|
      if hour.temperature > parameter
        hour.problems << "It's gona be too hot this hour!"
      end
    end
  end

  def too_cold?(database, parameter)
    database.all.each do |hour|
      if hour.temperature < parameter
        hour.problems << "It's gona be too cold this hour!"
      end
    end
  end

  def too_rainy?(database, parameter)
    database.all.each do |hour|
      if hour.rain > parameter
        hour.problems << "It's probably gonna rain this hour!"
      end
    end
  end

  def too_windy?(database, parameter)
    database.all.each do |hour|
      if hour.wind > parameter
        hour.problems << "It's gona be too windy this hour!"
      end
    end
  end
end

module CheckForProblematicWeather
  def run_parameters_against_problematic_criteria
    too_hot?(WeatherDatabase, hot_parameter)
    too_cold?(WeatherDatabase, cold_parameter)
    too_rainy?(WeatherDatabase, rain_parameter)
    too_windy?(WeatherDatabase, wind_parameter)
  end

  def is_there_any_problamatic_weather?
    !(!(WeatherDatabase.all.detect {|hour| hour.problems.length != 0}))
  end

  def list_out_hours_with_problamatic_weather
    WeatherDatabase.all.map do |hour|
      if hour.problems.length > 0
        puts "Problamatic Conditions for: #{hour.time}"
        counter = 0
        while hour.problems.length > counter
          puts "   #{counter + 1}.) #{hour.problems[counter]}"
          counter += 1
        end
        puts ""
      end
    end
  end

# The DataQuery module is the central engine of the whole program; it must accomplish the following tasks:
#   1.) take in a start & end time from the user (from the CLI)
#   2.) be smart enough to know if the user means am or pm, with the assumption the user won't enter a
#       time that is more than 11 hours out into the future, or the program will break.
#   3.) deal with the URL updates that take place at the .45 minute mark every hour
#   4.) send the user's start & end times to the <<time_of_the_day_analysed method in the CheckWeather class
#
  module DataQuery
    def when_r_u_going_out(start, finish)
      first_index = convert_todays_time_into_integers(start)
      second_index = convert_todays_time_into_integers(finish)
      time_of_the_day_analysed(first_index, second_index)
    end

    def convert_todays_time_into_integers(hour_you_are_going_out)
    # If I scrape the first instance [0] of hour from weather.com, I will get
    # the value of either:
    # 1.) The current hour if the current minute count is less than 45
    # 2.) The next hour if the current minute count is more than 45
    # This method is designed to deal with that issue
    # After the :45 minute mark, the program can no longer scrape weather data for
    # the current hour and so the first instanc [0] on weather.com will be for the
    # very next hour instead of the current hour.
      def time_offset(hour_you_are_going_out, eleven_or_12)
        x = Time.now.hour - 6 #=> This line of code makes it custom to Colorado Mountain Time (UTC - 6)
        if x >= 1
          x = x - eleven_or_12.to_i
        else
          x = x
        end
        z = hour_you_are_going_out.to_i - x
        if z < 0
          z + 12
        elsif z > 12
          z - 12
        elsif z == 12
          z = 0
        else
          z
        end
      end

      x = Time.now
      y = x.min
      if y < 45 #=> This is the point at which the weather.com page seems to update, but not always
        time_offset(hour_you_are_going_out, 12)
      else
        puts "Oops, my weather data updates between the 45 minute mark and the next hour, so I might break, do you want to continue? (y/n)"
        time_offset(hour_you_are_going_out, 11)
      end
    end
  end
end
 
