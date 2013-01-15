require "spec_helper"

describe PageLayout do
  let(:page_layout) { Fabricate(:page_layout) }
  describe "validations" do
    it "is valid" do
      page_layout.should be_valid
    end
  end
end