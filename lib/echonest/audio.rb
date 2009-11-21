module Echonest
  class Audio
    attr_accessor :location, :title, :artist, :info, :duration
    
    def initialize(options = {})
      @location = options[:location]
      @title = options[:title]
      @info = options[:info]
      @duration = options[:duration]
      @artist = options[:artist]
    end
    
    def self.build(xml)
      return unless xml.at('artist')
      options = {}
      options[:artist]    = Artist.new(:name => xml.at('artist').text)
      options[:title]     = xml.at('title').text    unless xml.at('title').nil?
      options[:location]  = xml.at('location').text unless xml.at('location').nil?
      options[:info]      = xml.at('info').text     unless xml.at('info').nil?
      options[:duration]  = xml.at('duration').text unless xml.at('duration').nil?
      new(options)
    end
  end
end