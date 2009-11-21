module Echonest
  class Connection
    attr_accessor :base_url
    
    def initialize(base_url)
      @base_url = base_url
    end
    
    def request(method, use_api, args = {})
      request_url = @base_url
      request_url += 'api/' if use_api == true
      request_url += "#{method}?#{encode(args)}"
      open(request_url).read
    end
    
    private 
    
    def encode(args = {})
      args.merge!(:version => 3, :api_key => Echonest.api_key)
      args.map { |k, v| "#{k}=#{v}" }.join("&")
    end
    
  end
end