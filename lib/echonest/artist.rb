module Echonest
  class Artist < Base
    
    attr_accessor :echonest_id, :name, :hotttnesss, :audio
    
    def initialize(options = {})
      @echonest_id = options[:id]
      @name = options[:name]
      @hotttnesss = options[:hotttnesss]
    end
    
    def self.build(xml)
      new(:id => xml.at("id").text, :name => xml.at("name").text, :hotttnesss => xml.at("hotttnesss").text)
    end
    
    def audio
      return @audio unless @audio.nil?
      response = self.class.request_and_parse("artist/#{request_name}/audio.xspf", false)
      @audio = response.search("track").map { |track| Echonest::Audio.build(track) }
      @audio
    end
    
    private
    
    # the api seems to accept '+' in place of / and ? for artists like 'AC/DC' and '?uestlove'
    def request_name
      @name.gsub("?", "+").gsub("/", "+").gsub(" ", "+")
    end
    
  end
end