require File.expand_path(File.join(File.dirname(__FILE__), "/../spec_helper.rb"))

describe Echonest::Charts do
  it "should be a subclass of Echonest::Base" do
    Echonest::Charts.superclass.should == Echonest::Base
  end
  
  describe ".get_top_hottt_artists(limit = 15)" do
    it "should make a request to the Echonest API" do
      response = mock("response", :search => [])
      Echonest::Charts.should_receive(:request_and_parse).with("get_top_hottt_artists", { :rows => 10 }).and_return(response)
      Echonest::Charts.get_top_hottt_artists(:rows => 10)
    end
    it "should build and Echonest::Artist objects from the API response" do
      artist = mock(Echonest::Artist)
      artist_xml = mock("artist xml")
      response = mock("response")
      Echonest::Charts.stub!(:request_and_parse).and_return(response)
      response.should_receive(:search).with("artist").and_return([artist_xml])
      Echonest::Artist.should_receive(:build).with(artist_xml).and_return(artist)
      Echonest::Charts.get_top_hottt_artists(:rows => 10).should == [artist]
    end
  end
end