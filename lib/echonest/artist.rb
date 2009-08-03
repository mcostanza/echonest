module Echonest
  class Artist < Base
    
    attr_accessor :echonest_id, :name, :hotttnesss
    
    def initialize(options = {})
      @echonest_id = options[:id]
      @name = options[:name]
      @hotttnesss = options[:hotttnesss]
    end
    
    def self.build(xml)
      new(:id => xml.at("id").text, :name => xml.at("name").text, :hotttnesss => xml.at("hotttnesss").text)
    end
    
  end
end