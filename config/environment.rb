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
# require_relative '../lib/engine/placeholder'
# require_relative '../lib/engine/placeholder'

# right now this require_all isn't working so I commented it out till I get to fixing it.
# require_all 'lib'

# so I don't know the difference between a "base fork" and a "head fork" so I'm gonna re-push this up and see
# which is which...I'm having no problems sending Red Burd's changes to Blud Burd, but when
# I try & push the newly updated Blue Burd repo to Greed Burd...everything gets screwed up :(


# OK so this time I'm going to try & update Red Burd's repo and then from there update it directly to
# Green Burds repo since that one is the master repo.
