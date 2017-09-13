# First you want to load Bundler:
require 'bundler'
# Require the gems from the gemfile
Bundler.require

require_all 'lib'

# So for some reason the require_all 'lib' works but this one will not.
# I have to use the require_relative statements below that refer to the
# individual tests themselves.
# require_all 'tests'

# this video here has relevant info for establishing requirements:
# https://www.youtube.com/watch?v=XBgZLm-sdl8
require 'nokogiri'
require 'open-uri'
require 'pry'

# You would use this require_relative if you don't have the require_all gem installed.
# This would prevent your program from running code you don't want or need in your subdirectories
# Avi says to just use the require_all gem instead

# OK so the require_all doesn't seem to be working after I pull in an updated GitHub repo so
# for now foreget it, I have the illustration with all the folders so I'm pretty good to just
# keep track of all the require_relative statements for now:

require_relative '../lib/check_weather'
require_relative '../lib/cli'
require_relative '../lib/data_requester'
require_relative '../lib/data_scraper'
require_relative '../lib/modules'
require_relative '../lib/weather_database'
require_relative '../lib/weather_parameters'

require_relative '../tests/data_scraper_test.rb'
require_relative '../tests/fake_test_weather_data.rb'
require_relative '../tests/foundation_scraper_test.rb'

# OK so now I have require_all working as I was missing the "require_all 'lib'" statement before.
# the four require_relative statements are still there above just for my reference, and just incase
# some poor user can't get the bundlre gem to work properly
