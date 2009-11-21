module Echonest
  class Base
    
    def self.request(method, use_api, args={})
      self.connection.request(method, use_api, args)
    end
  
    def self.connection
      @connection ||= Echonest::Connection.new("http://developer.echonest.com/")
    end
    
    def self.parse(response)
      Nokogiri::XML(response)
    end
        
    def self.request_and_parse(method, use_api, args={})
      parse(request(method, use_api, args))
    end
  
  end
end