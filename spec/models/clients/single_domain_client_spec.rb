require "spec_helper"

describe SingleDomainClient do
  describe "validations" do
    it "should require a domain" do
      Fabricate.build(:client, type: "SingleDomainClient", domain: "").should_not be_valid
    end
  end

  describe "#url_formatter_class" do
    before { Fabricate(:client, type: "SingleDomainClient") }

    it "returns the correct formatter" do
      expect(Client.first.url_formatter_class).to eq(URLFormat::SingleDomainFormatter)
    end
  end
end
