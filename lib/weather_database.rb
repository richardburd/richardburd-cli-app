require_relative '../config/environment'

class WeatherDatabase
  attr_accessor :time, :rain, :temperature, :cloud, :wind, :problems
  @@all = []

  def initialize
    @@all << self
    @problems = []
  end

  def self.all
    @@all
  end

  def self.delete_all
    @@all = []
  end
end
