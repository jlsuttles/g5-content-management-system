require "spec_helper"

shared_examples_for ComponentGardenable do
  describe "#garden_microformats", vcr: VCR_OPTIONS do
    it "returns microformats when no error" do
      described_class.garden_microformats.should be_present
    end

    it "returns @microformats if there is an OpenURI::HTTPError 304" do
      described_class.garden_microformats
      Microformats2::Parser.any_instance.stub(:parse).
        and_raise(OpenURI::HTTPError.new("304 Not Modified", nil))
      described_class.garden_microformats.should be_present
    end

    it "raises error if there is an OpenURI::HTTPError other than 304" do
      Microformats2::Parser.any_instance.stub(:parse).
        and_raise(OpenURI::HTTPError.new("400 Not Found", nil))
      expect{ described_class.garden_microformats }.to raise_error(OpenURI::HTTPError)
    end
  end
end

describe WebLayout do
  it_behaves_like ComponentGardenable
end

describe WebTheme do
  it_behaves_like ComponentGardenable
end

describe Widget do
  it_behaves_like ComponentGardenable
end
