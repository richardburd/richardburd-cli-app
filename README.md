# Boulder-WeatherCheck

## Background

<p class='util--hide'>Welcome to the “Boulder-Weathercheck” program by [me] Richard Burd!  I am a student at the Flatiron School and this is my submission for <a href='https://github.com/learn-co-students/oo-student-scraper-v-000'>this project here</a> on Learn.co.</p>

## About This Program

The purpose of this program is to check the Boulder Colorado weather and see if it's OK to go outside.  I could check the weather online but then I have to look at the complete hourly forecast for the entire day; this program just checks a specific timeframe that the user specifies so the user only sees weather for that time-frame, and nothing more.  The user can also specify the weather conditions they're willing to tolerate and will be told whether or not the weather conforms to those conditions the user finds tolerable; the objective is to get a quick answer on whether or not the user wants to go outside for exercise, or stay indoors.

## Install instructions

You will need Ruby installed on your machine to run this program; you will also need to download and install the Nokogiri and Open-Uri Ruby Gems...but you do not need Bundler.  After grabbing the necessary gems, clone a copy of this repo onto your machine and run the `boulder-weathercheck` file in the `bin` directory to execute the program, follow the instructions on the command line interface to enter data and receive results.

### Project Structure

```
├── README.md
├── bin
│   ├── boulder-weathercheck
│   └── console
├── config
│   └── environment.rb
├── lib
│   ├── check_weather.rb
│   ├── cli.rb
│   ├── data_requester.rb
│   ├── data_scraper.rb
│   ├── modules.rb
│   ├── check_weather.rb
│   ├── weather_database.rb
│   └── weather_parameters.rb
└── tests
        ├── data_scraper_test.rb
        ├── fake_test_weather.rb
        └── foundation_scraper_test.rb
```

## Contributors Guide

There are three GitHub accounts contributing to this project; they are all me [I promise] and will be referred to herein as “Red-Burd,” “Green-Burd,” and “Blue-Burd” commensurate with the avatar icons for each account.  My objective in using three accounts is to experiment with (and learn about) GitHub’s multi-user functionality; although this is the whole point of GitHub, all of my Flatiron School projects (to date) have involved only one user (me) submitting to a repo. I want to try & push GitHub to its limits in terms of seeing how it handles multiple users trying to submit conflicting code at the same time, the purpose of all this is to turn me into a GitHub master.  If you would like to contribute to the project as well, you can go ahead and submit a pull request, but I won’t incorporate any of your code until I’ve been graded on this assignment...anything else would be cheating!

## Notes for My Instructor

### Overview

<p class='util--hide'> I started writing the URL scraping code on a single ruby file several weeks ago just to play around with Nokogiri a bit; that single ruby file (believe it or not) evolved into the whole program.  I never created a Git Repo or setup a proper working environment because I wasn’t that comfortable with GitHub to be honest, and so I wanted to just get my code working.  My strategy was to first get all the code working correctly and then make a proper Git repo and do some refactoring along the way.  The tool I used to organize the whole thing is my 'process_flow_illustration.svg’ file; the original ruby file of the fully-working program is <a href='https://drive.google.com/open?id=0B4e44pJ1yCAtRjdXcWNMaG56bDQ'>available here</a> on my google drive.</p>

### Project Requirements

This assignment asks us to do two things with data we pull from an external source:

1. Implement a list view
2. Implement a detail view

This program accomplishes the first implementation by asking the user if they would like to view problematic
weather, the program accomplishes the latter implementation by showing a list of all weather conditions
associated with the timeframe queried.  The first implementation will not execute if the weather is good for
the specified time, so to make it run, the user must select “custom parameters” in the CLI and set the
conditions to weather extremes; this will trigger the first implementation to execute and show the user
results.
