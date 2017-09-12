class BoulderWeatherCheck
end

# This is the CLI Controller that encapsulates the business logic
class BoulderWeatherCheck::CLI
  attr_accessor :start_hour, :end_hour
  
  def call
    program_use
    update_warning
    custom_or_default_weather_parameters
    select_start_time
    select_end_time
    start_and_end_times_different
    run_program
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
      can only predict the weather 12 hours out from now,
      so don't ask me for anything else.
    DOC
    puts "\nPress any key to continue"
    user_input = gets.chomp.downcase
    puts " \n"
  end
  
  def custom_or_default_weather_parameters 
    puts "Which weather settings would you prefer to use?"
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
    end
  end 
  
  def custom_weather_parameters 
    puts "\nthe (custom_weather_parameters) method goes here, press any key to continue\n"
    user_input = gets.chomp.downcase
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
      puts "\nOops, ther start & end times are exactly the same; this means I'll crash when I go to grab my data since I can only see 12 hours into the future from the current hour. \n"
      select_start_time
      select_end_time
    end 
  end 

  def valid_entry(input)
    x = input.to_i 
    if x <= 0 || x >= 13
      puts "\nI'm sorry but I could not reconize that number, enter a number between 1 and 12"
      select_time 
    else
      if self.start_hour == nil
        self.start_hour = x
      elsif self.start_hour != nil 
        self.end_hour = x
      end 
    end 
  end
  
  def good_bye
    puts "\nThank you and see you next time."
    exit
  end
  
  def update_warning 
    x = Time.now
    y = x.min
    if y >= 45  
      puts "WARNING: my data updates between the 45 minute mark and the next hour, so I might break!...would you like to continue? (y/n)"
      user_input = gets.chomp.downcase
      simple_yes_or_no_question(user_input)
    end
  end 
  
  def run_program 
    puts "\nOk let me check the weather between #{self.start_hour} and #{self.end_hour}, this might take a sec..."
    puts "\nthis is where you want to insert the (when_r_u_going_out(start, finish)) method"
  end 
  
  def is_the_weather_suitable
    puts "\nis (is_there_any_problamatic_weather?) correct?\n"
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
    puts "\nthis is where you put the (display_problematic_weather) method" 
  end 
  
  def option_to_see_weather_by_the_hour 
    puts "\nWould you like to see the complete weather listing by the hour for the period of time you selected? (y/n)"
    user_input = gets.chomp.downcase
    while user_input != "y" && user_input != "yes"
      if user_input == "n" || user_input == "no"
        option_to_continue
      else
        puts "Huh!?  type y or n"
        user_input = gets.chomp.downcase
      end 
    end 
    puts "\nthis is where you put the (display_weather) method"
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
    puts "\nthis is where you insert: (delete_database)\n"
    puts 
    BoulderWeatherCheck::CLI.new.call
  end  
end

BoulderWeatherCheck::CLI.new.call


# Add a (start_and_end_times_different) method

# Add a method that will allow the user to set the 
# max temperature they are comfortable with?







