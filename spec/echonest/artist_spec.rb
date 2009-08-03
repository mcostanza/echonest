require File.expand_path(File.join(File.dirname(__FILE__), "/../spec_helper.rb"))

describe Echonest::Artist do
  before(:each) do
    @options = { :name => 'Little Brother', :hotttnesss => 0.54, :id => 'id' }
    @artist = Echonest::Artist.new(@options)
  end
  
  it "should be a subclass of Echonest::Base" do
    Echonest::Artist.superclass.should == Echonest::Base
  end
  
  describe "attributes" do
    %w[echonest_id name hotttnesss].each do |attribute|
      it "should have an attr_accessor for @#{attribute}" do
        @artist.should respond_to(attribute)
        @artist.should respond_to("#{attribute}=")
      end
    end
  end
  
  describe ".initialize(options = {})" do
    it "should set the echonest_id" do
      @artist.echonest_id.should == 'id'
    end
    it "should set the name" do
      @artist.name.should == 'Little Brother'
    end
    it "should set the hotttnesss" do
      @artist.hotttnesss.should == 0.54
    end
  end
  
  describe ".build(xml)" do
    before(:each) do
      fixture_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'fixtures', 'get_top_hottt_artists.xml'))
      @xml = Nokogiri::XML(File.read(fixture_path)).at("artist")
    end
    it "should initialize and return an Echonest::Artist with echonest id, name, and hotttnesss" do
      artist = mock(Echonest::Artist)
      Echonest::Artist.should_receive(:new).with(:id => "music://id.echonest.com/~/AR/AR0IVTL1187B9AD520", :name => "Katy Perry", :hotttnesss => "1.0").and_return(artist)
      Echonest::Artist.build(@xml).should == artist
    end
  end
end