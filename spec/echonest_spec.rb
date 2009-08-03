require File.expand_path(File.join(File.dirname(__FILE__), "/spec_helper.rb"))

describe Echonest do
  it "should have a class attr_accessor for @api_key" do
    Echonest.should respond_to(:api_key)
    Echonest.should respond_to(:api_key=)
  end
end
