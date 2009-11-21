require File.dirname(__FILE__) + '/../spec_helper.rb'

describe Echonest::Base do
  
  describe ".connection" do
    it "should be an instance of Echonest::Connection" do
      Echonest::Base.connection.class.should == Echonest::Connection
    end
    it "should be cached" do
      Echonest::Base.connection.should === Echonest::Base.connection
    end
  end
  
  describe ".request(api_method, args={})" do
    it "should make a request to the connection url" do
      method        = "get_top_hottt_artists"
      args          = { :arg => "value" }
      Echonest::Base.connection.should_receive(:request).with(method, true, args)
      Echonest::Base.request(method, true, args)
    end
  end
  
  describe ".parse(response)" do
    it "should return a Nokogiri::XML object from the response" do
      xml = mock('Nokogiri')
      Nokogiri.should_receive(:XML).with('response').and_return(xml)
      Echonest::Base.parse('response').should == xml
    end
  end
  
  describe ".request_and_parse(api_method, args={})" do
    before(:each) do
      @method   = "get_top_hottt_artists"
      @args     = { :arg => "value" }
      @use_api  = true
      @response = StringIO.new("response")
    end
    it "should make a request" do
      Echonest::Base.should_receive(:request).with(@method, @use_api, @args).and_return(@response)
      Echonest::Base.stub!(:parse)
      Echonest::Base.request_and_parse(@method, @use_api, @args)
    end
    it "should parse the response" do
      Echonest::Base.stub!(:request).and_return(@response)
      Echonest::Base.should_receive(:parse).with(@response)
      Echonest::Base.request_and_parse(@method, @use_api, @args)
    end
  end
  
end
