require_relative '../config/environment'

class DataScraper                                                                  #https://weather.com/weather/hourbyhour/l/USCO0038:1:US
  def weather_scraper_1(index = nil, targeted_html = nil, custom_gsub = nil, url = "https://weather.com/weather/hourbyhour/l/Boulder+CO+USCO0038:1:US")
    html = open(url)
    item = Nokogiri::HTML(html)
    eval("item.css(targeted_html)[index.to_i].text#{custom_gsub}")
  end

  def weather_scraper_2
    # if you want to add data not available on weather.com such as UV index; put that here.
  end
end
