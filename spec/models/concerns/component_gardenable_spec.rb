require "spec_helper"

shared_examples_for ComponentGardenable do
  describe "#garden_microformats" do
    it "returns microformats when no error" do
      described_class.garden_microformats.should be_present
    end
    it "returns @microformats if there is an OpenURI::HTTPError" do
      described_class.garden_microformats
      Microformats2::Parser.stub(:parse).and_raise(OpenURI::HTTPError)
      described_class.garden_microformats.should be_present
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
