require File.expand_path(File.join(File.dirname(__FILE__), "/../spec_helper.rb"))

describe Echonest::Audio do
  before(:each) do
    @artist = Echonest::Artist.new(:name => 'Little Brother')
    @options = { 
      :title => 'The Way You Do It', 
      :info => 'http://littlebrother.com', 
      :location => 'http://littlebrother.com/the-way-you-do-it.mp3',
      :artist => @artist,
      :duration => '100.0'
    }
    @audio = Echonest::Audio.new(@options)
  end
    
  describe "attributes" do
    %w[title info location artist duration].each do |attribute|
      it "should have an attr_accessor for @#{attribute}" do
        @audio.should respond_to(attribute)
        @audio.should respond_to("#{attribute}=")
      end
    end
  end
  
  describe ".initialize(options = {})" do
    it "should set the title" do
      @audio.title.should == @options[:title]
    end
    it "should set the artist" do
      @audio.artist.should == @artist
    end
    it "should set the location" do
      @audio.location.should == @options[:location]
    end
    it "should set the info" do
      @audio.info.should == @options[:info]
    end
    it "should set the duration" do
      @audio.duration.should == @options[:duration]
    end
  end
  
  describe ".build(xml)" do
    before(:each) do
      fixture_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'fixtures', 'artist_audio.xspf'))
      @xml = Nokogiri::XML(File.read(fixture_path)).at("track")
    end
    it "should initialize and return an Echonest::Audio with title, info, artist, and duration" do
      artist = mock(Echonest::Artist)
      Echonest::Artist.should_receive(:new).with(:name => 'Little Brother').and_return(artist)
      audio = mock(Echonest::Audio)
      Echonest::Audio.should_receive(:new).with(
        :title => "Good Clothes",
        :info => "http://hellovegetables.com/2009/07/06/bobby-brown-patent-leather-members-only-jacket/",
        :location => "http://hellovegetables.com/music/HV525%20Little%20Brother%20-%20Good%20Clothes.mp3",
        :artist => artist,
        :duration => '278.0'
      ).and_return(audio)
      Echonest::Audio.build(@xml).should == audio
    end
    it "should return if no artist for the track is found" do
      @xml.should_receive(:at).with('artist').and_return(nil)
      Echonest::Audio.build(@xml).should be_nil
    end
  end
end