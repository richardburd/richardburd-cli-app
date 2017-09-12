# First you want to load Bundler:
require 'bundler'
# Require the gems from the gemfile
Bundler.require

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

require_relative '../lib/scratch_test'
# require_relative '../lib/cli'
# require_relative '../lib/weather_parameters'
require_relative '../lib/modules'
require_relative '../lib/weather_database'
