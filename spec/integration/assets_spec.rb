require "spec_helper"

describe "Integration assets", js: true, vcr: VCR_OPTIONS do
  before do
    @client, @location, @website = seed
    visit_assets
  end

  it "shows the file select input" do
    page.should have_css "input[type=file]"
  end

  context "has assets" do
    it "shows an asset" do
      page.should have_css "li.asset"
    end
  end
end
