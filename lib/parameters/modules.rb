module ProblematicWeatherDefined
  
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