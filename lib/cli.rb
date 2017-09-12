class BoulderWeatherCheck
end

# This is the CLI Controller that encapsulates the business logic
class BoulderWeatherCheck::CLI
  attr_accessor :first_hour, :final_hour
  
  def call
    program_use
    update_warning
    select_start_time
#    select_end_time
#    run_program
#    good_bye
  end

  def program_use
    puts "Welcome to the Boulder Weather-Check Program!\n\n"
    puts <<-DOC.gsub /^\s*/, ''
      The program will tell you if the weather in
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
    puts "Enter the final hour of your outdoor adventure or type exit to leave the program"
    select_time
  end

  def select_time 
    input = gets.strip
    if input != "exit"
      valid_entry(input)
    else 
      good_bye
    end
  end 
  

  def valid_entry(input)
    x = input.to_i 
    if x <= 0 || x >= 13
      puts "I'm sorry but I could not reconize that number, enter a number between 1 and 12"
      select_time 
    else
      puts "you chose #{input}"
    end 
  end
  
  def good_bye
    puts "Thank you and see you next time."
  end
  
  def update_warning 
    x = Time.now
    y = x.min
    if y >= 45  
      puts "WARNING: my data updates between the 45 minute mark and the next hour, so I might break!...would you like to continue? (y/n)"
      user_input = gets.chomp.downcase 
      if user_input = "n"
        good_bye 
      elsif user_input = "y"
        puts "you just said yes"
      end 
    end
  end 
  
  def run_program 
    puts "Ok let me check the weather between #{self.first_hour} and #{self.final_hour}, this might take a sec..."
  end 
end

BoulderWeatherCheck::CLI.new.call

# Add a warning about using the program after the :45 minute mark

# Ask the user (after running the program) if they would
# like to see the weather displayed for each hour.








