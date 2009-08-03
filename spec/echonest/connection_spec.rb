require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Echonest::Connection do
  before(:each) do
    @base_url = "http://developer.echonest.com/api"
    @api_key = "key"
    Echonest.api_key = @api_key
  end
  
  describe ".initialize(base_url)" do
    it "should set the base_url for the Connection" do
      Echonest::Connection.new(@base_url).base_url.should == @base_url
    end
  end
  
  describe ".request(url_path, args = {}, method = :get)" do
    before(:each) do
      @connection = Echonest::Connection.new(@base_url)
    end
    it "should convert args to url parameters when making a request" do
      args         = { :rows => 2 }
      api_method   = "get_top_hottt_artists"
      request_url  = "http://developer.echonest.com/api/get_top_hottt_artists?api_key=key&version=3&rows=2"
      response     = StringIO.new("response")
      @connection.should_receive(:open).with(request_url).and_return(response)
      @connection.request(api_method, args)  
    end
    
    it "should return the result of reading the response" do
      response = StringIO.new("response")
      @connection.stub!(:open).and_return(response)
      @connection.request("method", {}).should == "response"
    end

  end
  
end
