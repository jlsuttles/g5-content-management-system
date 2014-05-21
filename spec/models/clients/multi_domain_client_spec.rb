require "spec_helper"

describe MultiDomainClient do
  describe "validations" do
    it "should not require a domain" do
      Fabricate.build(:client, domain: "").should be_valid
    end
  end

  describe "#url_formatter_class" do
    before { Fabricate(:client) }

    it "returns the correct formatter" do
      expect(Client.first.url_formatter_class).to eq(URLFormat::MultiDomainFormatter)
    end
  end
end
