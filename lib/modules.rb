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
end

# The DataQuery module is the central engine of the whole program; it must accomplish the following tasks:
#   1.) take in a start & end time from the user (from the CLI)
#   2.) be smart enough to know if the user means "am" or "pm" with the assumption the user won't enter a
#       time that is more than 11 hours out into the future, or the program will break.
#   3.) deal with the URL updates that take place at the .45 minute mark every hour
#   4.) send the user's start & end times to the <<time_of_the_day_analysed method in the CheckWeather class
#       so it can begin to iterate from the start time to the end time and request a
#       scrape for each hour in-between.
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
    # the current hour and so the first instance [0] on weather.com will be for the
    # very next hour instead of the current hour.
    def time_offset(hour_you_are_going_out, eleven_or_12)
      # This line of code makes it custom to Colorado Mountain Time (UTC - 6)
      # Colorado is technically UTC - 7 but the weird math just works out this
      # way instead.
      mountain_time = Time.now.hour - 6

      # This section figures out how to take in a time from the user (that will be a
      # number between 1 and 12) and turn that number into an integer between 1 and
      # 24; essentially making it military time.  The code than says, OK, well, the
      # current time is the time of the very first instance [0] of time that is being
      # scrapped from the URL, so from there we need to figure out what the user means
      # when (for example) they type in "4" as in 4:00; where is 4:00 in the actual index
      # of hours being scrapped!?  Is it [0], [1], or [2] or what?

      # Now honeslty, I have no idea how this all works because I never drew or graphed
      # it out, I just ran the program several times throughout the "am" and "pm" hours
      # over a period of a week and I kept playing around with these numbers until they
      # just worked...very un-scientific I know, but it works...somehow.

      # I never bothered building the rest of this program (the CLI and the weather
      # parameters) until I got this part working just right.
      if mountain_time >= 1
        mountain_time = mountain_time - eleven_or_12.to_i
      else
        mountain_time = mountain_time
      end

      mountain_hour_you_are_goint_out = hour_you_are_going_out.to_i - mountain_time # mountain_hour_you_are_goint_out
      if mountain_hour_you_are_goint_out < 0
        mountain_hour_you_are_goint_out + 12
      elsif mountain_hour_you_are_goint_out > 12
        mountain_hour_you_are_goint_out - 12
      elsif mountain_hour_you_are_goint_out == 12
        mountain_hour_you_are_goint_out = 0
      else
        mountain_hour_you_are_goint_out
      end
    end

    # Alright, so here's the deal; if we ran this method here in the test folder:

    # def single_hour_scraper
    #   html = open("https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
    #   list = Nokogiri::HTML(html)
    #   list.css(".dsx-date").text[0]
    # end

    # ... the [0] index would be the CURRENT HOUR unless the CURRENT TIME is past the :45
    # minute mark...so between the :45 minute mark and the start of the next hour, the
    # [0] index is actually the NEXT HOUR and not the current one.  This means that if the
    # current time is 1:48 pm for example, you cannot find any weather data for the 1:00 pm
    # hour because the [0] index will actually be the 2:00 pm hour.
    # THIS RULE IS NOT ALWAYS TRUE!! because weather.com is not 100% consistant on how it
    # updates its weather data; for that reason this whole program will be broken from
    # time to time between the :45 minute mark and the start of the new hour.
    current_time = Time.now
    current_time_minute_mark = current_time.min
    if current_time_minute_mark < 45
      time_offset(hour_you_are_going_out, 12)
    else
  #    I don't need this while the program is working
  #    But I'm leaving it here cause it's helpful for debugging
  #    puts "Oops, my weather data updates between the 45 minute mark and the next hour, so I might break, do you want to continue? (y/n)"
      time_offset(hour_you_are_going_out, 11)
    end
  end
end
