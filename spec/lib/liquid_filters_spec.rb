require 'spec_helper'

describe UrlEncode do
  describe "#url_encode" do
    it "url encodes a string" do
      object = Object.new.extend(UrlEncode)
      encoded = object.url_encode("has spaces")
      encoded.should == "has%20spaces"
    end
  end
end
