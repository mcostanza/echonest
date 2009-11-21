$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'nokogiri'

require 'open-uri'

require 'echonest/connection'
require 'echonest/base'
require 'echonest/charts'
require 'echonest/artist'
require 'echonest/audio'

module Echonest
  VERSION = '0.0.1'
  
  class << self
    attr_accessor :api_key
  end
  
end