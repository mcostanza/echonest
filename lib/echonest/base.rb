module Echonest
  class Base
    
    def self.request(api_method, args={})
      self.connection.request(api_method, args)
    end
  
    def self.connection
      @connection ||= Echonest::Connection.new("http://developer.echonest.com/api/")
    end
    
    def self.parse(response)
      Nokogiri::XML(response)
    end
        
    def self.request_and_parse(api_method, args={})
      parse(request(api_method, args))
    end
  
  end
end