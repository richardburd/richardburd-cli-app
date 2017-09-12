class BoulderWeatherCheck
end

# This is the CLI Controller that encapsulates the business logic
class BoulderWeatherCheck::CLI
  attr_accessor :start_hour, :end_hour
  
  def call
    program_use
    update_warning
    select_start_time
    select_end_time
    run_program
    option_to_see_weather_by_the_hour
#    option_to_continue 
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
    puts " \n"
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
  end 
  
  def option_to_see_weather_by_the_hour 
    puts "\nWould you like to see the weather by the hour for the period of time you selected? (y/n)"
    user_input = gets.chomp.downcase
    simple_yes_or_no_question(user_input)
    puts "\nthis is where you put the (display_weather) method"
  end
  
  def option_to_continue 
    puts "Would you like to enter another timeslot?"
  end 
  
  def simple_yes_or_no_question(user_input) 
    while user_input != "y" && user_input != "yes"
      if user_input == "n" || user_input == "no"
        good_bye
        exit
      else
        puts "Huh!?  type y or n"
        user_input = gets.chomp.downcase
      end 
    end 
  end 
  
  def option_to_continue 
    puts "\nWould you like to run the program again and check another timeslot?"
    simple_yes_or_no_question(user_input)
    puts "this is where you insert: (delete_database)"
    BoulderWeatherCheck::CLI.new.call
  end  
end

BoulderWeatherCheck::CLI.new.call


# Add a method (option_to_continue) that will delete the current 
# WeatherDatabase and allow you to start the program 
# all over again.

# Add a method that will allow the user to set the 
# max temperature they are comfortable with?







