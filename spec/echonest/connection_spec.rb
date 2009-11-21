require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Echonest::Connection do
  before(:each) do
    @base_url = "http://developer.echonest.com/"
    @api_key = "key"
    Echonest.api_key = @api_key
  end
  
  describe ".initialize(base_url)" do
    it "should set the base_url for the Connection" do
      Echonest::Connection.new(@base_url).base_url.should == @base_url
    end
  end
  
  describe ".request(url_path, use_api, args = {})" do
    before(:each) do
      @connection = Echonest::Connection.new(@base_url)
    end
    it "should convert args to url parameters when making a request" do
      args         = { :rows => 2 }
      api_method   = "get_top_hottt_artists"
      response     = StringIO.new("response")
      @connection.should_receive(:open).with do |url|
        url.should =~ /http:\/\/developer\.echonest\.com\/api\/get_top_hottt_artists\?/
        url.should =~ /rows=2/
        url.should =~ /version=3/
        url.should =~ /api_key=key/
      end.and_return(response)
      @connection.request(api_method, true, args)  
    end
    
    it "should return the result of reading the response" do
      response = StringIO.new("response")
      @connection.stub!(:open).and_return(response)
      @connection.request("method", true, {}).should == "response"
    end

    it "should not nest the url under /api if use_api is false" do
      args         = {}
      api_method   = "artist/Little+brother/audio.xspf"
      response     = StringIO.new("response")
      @connection.should_receive(:open).with do |url|
        url.should =~ /http:\/\/developer\.echonest\.com\/artist\/Little\+brother\/audio\.xspf\?/
        url.should =~ /version=3/
        url.should =~ /api_key=key/
      end.and_return(response)
      @connection.request(api_method, false, args)  
    end

  end
  
end
