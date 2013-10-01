require "spec_helper"

class Component
  include ComponentGardenable
  set_garden_url ENV["WIDGET_GARDEN_URL"]
end

describe ComponentGardenable, vcr: VCR_OPTIONS do
  describe "#garden_microformats" do
    it "returns microformats when no error" do
      Component.garden_microformats
      Component.garden_microformats.should be_present
    end

    it "returns @microformats if there is an OpenURI::HTTPError 304" do
      Component.garden_microformats
      Microformats2::Parser.any_instance.stub(:parse).
        and_raise(OpenURI::HTTPError.new("304 Not Modified", nil))
      Component.garden_microformats.should be_present
    end

    it "raises error if there is an OpenURI::HTTPError other than 304" do
      Microformats2::Parser.any_instance.stub(:parse).
        and_raise(OpenURI::HTTPError.new("400 Not Found", nil))
      expect{ Component.garden_microformats }.to raise_error(OpenURI::HTTPError)
    end
  end
end
