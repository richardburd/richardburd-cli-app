require_relative '../config/environment'
require_relative 'weather_parameters'
require_relative 'check_weather'
require_relative 'modules'

class BoulderWeatherCheck
end

class BoulderWeatherCheck::CLI
  attr_accessor :start_hour, :end_hour
  WEATHER_PARAMETERS = WeatherParameters.new

  def call
    program_use
    update_warning
    select_start_time
    select_end_time
    start_and_end_times_different
    run_program
    custom_or_default_weather_parameters
    is_the_weather_suitable
    option_to_see_problematic_weather_by_the_hour
    option_to_see_weather_by_the_hour
    option_to_continue
    good_bye
  end

  def program_use
    puts "Welcome to the Boulder Weather-Check Program!\n\n"
    puts <<-DOC.gsub /^\s*/, ''
      This program will tell you if the weather in
      Boulder Colorado is suitable for outdoor
      recreational activities during a timeframe
      you specify.
    DOC
    puts " \n"
    puts <<-DOC.gsub /^\s*/, ''
      I'm smart so you can be lazy! I will figure out
      if you want 'am' or 'pm' times; keep in mind that I
      can only predict the weather 11 hours out from now,
      so don't ask me for anything else or I'll crash on you.
    DOC
    puts "\nPress any key to continue"
    user_input = gets.chomp.downcase
    puts " \n"
  end

  def custom_or_default_weather_parameters
    puts "\nWhich weather settings would you prefer to use?"
    puts ""
    puts "    1.) Default weather settings"
    puts ""
    puts "    2.) Your own customized weather settings"
    puts "\nChoose 1 or 2"
    user_input = gets.chomp.downcase
    if user_input == "2"
      custom_weather_parameters
    else
      while user_input != "1"
        puts "Huh!?  type 1 or 2"
        user_input = gets.chomp.downcase
      end
      puts "you have chosen to use my default parameters."

      WEATHER_PARAMETERS.use_default_parameters
      puts "press any key to continue"
      user_input = gets.chomp.downcase
    end
  end

  def custom_weather_parameters
    puts "\nWhat is the maximum air temperature (°F) you're willing to go outside in?\n"
    user_input_1 = gets.chomp
    first_custom_input = valid_value(user_input_1, "-40", "110")
    puts "\nOK cool...what is the minimum air temperature (°F) you're willing to go out in?"

    user_input_2 = gets.chomp
    second_custom_input = valid_value(user_input_2, "-40", "110")
      while first_custom_input < second_custom_input
        puts "\nUh oh, you can't hava a minimum temperature that is higher than your maximum temperature; please enter a lower value"
          second_custom_input = gets.chomp
          second_custom_input = valid_value(second_custom_input, "-40", "110")
      end

    # OK so you need this instance of valid_value after the previous comparrison:
    # "first_custom_input < second_custom_input" because otherwise the program will
    # not check again to make sure the "second_custom_input" is in fact within proper range.
    second_custom_input = valid_value(second_custom_input, "-40", "110")

    puts "\nNow tell me maximum percentage-chance of rain you're willing to tolerate?"
    user_input_3 = gets.chomp
    third_custom_input = valid_value(user_input_3, "0", "100")
    puts "\nFinally, what is the maximum wind-speed (miles-per-hour) you're willing to tolerate?"
    user_input_4 = gets.chomp
    forth_custom_input = valid_value(user_input_4, "0", "200")

    WEATHER_PARAMETERS.use_user_defined_parameters(first_custom_input, second_custom_input, third_custom_input, forth_custom_input)

    puts "\nCool, so here's where we stand:"
    puts "Maximum Temperature: #{WEATHER_PARAMETERS.hot_parameter}°"
    puts "Minimum Temperature: #{WEATHER_PARAMETERS.cold_parameter}°"
    puts "Maximum Chance of Precipitation: #{WEATHER_PARAMETERS.rain_parameter}%"
    puts "Maximum Allowable Windspeed: #{WEATHER_PARAMETERS.wind_parameter}mph"
    puts "\nPress any key to continue"
    user_input = gets.chomp
  end

  def select_start_time
    puts "\nEnter the first hour you would like to go out or type exit to leave the program"
    select_time
  end

  def select_end_time
    puts "\nEnter the final hour of your outdoor adventure or type exit to leave the program"
    select_time
  end

  def select_time
    input = gets.strip
    if input != "exit"
      valid_entry(input)
    else
      good_bye
      exit
    end
  end

  def start_and_end_times_different
    if self.start_hour == self.end_hour
      puts "\nOops, ther start & end times are exactly the same; this means I'll crash when I go to grab my data since I can only see 11 hours into the future from the current hour. \n"
      select_start_time
      select_end_time
    end
  end

  def valid_value(input, min_value, max_value)
    while any_letters_present?(input) || numbers_are_out_of_bounds?(input, min_value, max_value)
      puts "\nOops there's a problem here..."
      if any_letters_present?(input)
        puts "\n...You can't use letters!"
      elsif numbers_are_out_of_bounds?(input, min_value, max_value)
        puts "\n...Whoa that's crazy, please enter a value between #{min_value} and #{max_value}"
      end
      input = gets.chomp
    end
    input.to_i
  end

  def numbers_are_out_of_bounds?(input, min_value, max_value)
      input.to_i < min_value.to_i || input.to_i > max_value.to_i
  end

  def any_letters_present?(input)
    !(!(input.to_s.match(/[a-zA-Z]/)))
  end

  def valid_entry(input)
    user_entered_hour = input.to_i
    if user_entered_hour <= 0 || user_entered_hour >= 13
      puts "\nI'm sorry but I could not reconize that number, enter a number between 1 and 12"
      select_time
    else
      if self.start_hour == nil
        self.start_hour = user_entered_hour
      elsif self.start_hour != nil
        self.end_hour = user_entered_hour
      end
    end
  end

  def good_bye
    puts "\nThank you for using the Boulder Weather-Check program and see you next time."
    exit
  end

  def update_warning
    time_right_now = Time.now
    minute_right_now = time_right_now.min
    if minute_right_now >= 45
      puts "WARNING: Right now I can't analyize weather for the current hour; also, my data updates between the 45 minute mark and the next hour, so I might break!...would you like to continue? (y/n)"
      user_input = gets.chomp.downcase
      simple_yes_or_no_question(user_input)
    end
  end

  def run_program
    puts "\nOk let me check the weather between #{self.start_hour} and #{self.end_hour}, this might take a sec..."
    go = CheckWeather.new
    go.when_r_u_going_out(self.start_hour, self.end_hour)
  end

  def is_the_weather_suitable
    WEATHER_PARAMETERS.run_parameters_against_problematic_criteria
    if WEATHER_PARAMETERS.is_there_any_problamatic_weather? == true
      puts "\nOh no, you can't go outside, the weather's not suitable! :("
    else
      puts "\nCool, the weather's gonna be OK outside."
      option_to_see_weather_by_the_hour
      option_to_continue
      good_bye
    end
  end

  def option_to_see_problematic_weather_by_the_hour
     puts "\nWould you like to see the problematic weather by the hour for the period of time you selected? (y/n)"
    user_input = gets.chomp.downcase
    while user_input != "y" && user_input != "yes"
      if user_input == "n" || user_input == "no"
        option_to_see_weather_by_the_hour
      else
        puts "Huh!?  type y or n"
        user_input = gets.chomp.downcase
      end
    end
    puts "\n"
    WEATHER_PARAMETERS.list_out_hours_with_problamatic_weather
  end

  def display_weather
    WeatherDatabase.all.map do |hour|
      puts "#{hour.time}, Conditions:"
      puts "Temperature feels like: #{hour.temperature}°"
      puts "Chance of precipitation: #{hour.rain}%"
      puts "Cloud conditions: #{hour.cloud}"
      puts "Windspeed is #{hour.wind}mph"
      puts
    end
  end

  def option_to_see_weather_by_the_hour
    puts "\nWould you like to see the complete weather listing anyways for the period of time you selected? (y/n)"
    user_input = gets.chomp.downcase
    while user_input != "y" && user_input != "yes"
      if user_input == "n" || user_input == "no"
        option_to_continue
      else
        puts "Huh!?  type y or n"
        user_input = gets.chomp.downcase
      end
    end
    puts ""
    display_weather
  end

  def simple_yes_or_no_question(user_input)
    while user_input != "y" && user_input != "yes"
      if user_input == "n" || user_input == "no"
        good_bye
      else
        puts "Huh!?  type y or n"
        user_input = gets.chomp.downcase
      end
    end
  end

  def option_to_continue
    puts "\nWould you like to run the program again and check another timeslot (y/n)?"
    user_input = gets.chomp.downcase
    simple_yes_or_no_question(user_input)
    WeatherDatabase.delete_all
    WeatherParameters.delete_all
    puts
    BoulderWeatherCheck::CLI.new.call
  end
end
