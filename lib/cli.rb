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
 end 