require "spec_helper"

describe MultiDomain do
  describe "#url_formatter_class" do
    before { Fabricate(:client) }

    it "returns the correct formatter" do
      expect(Client.first.url_formatter_class).to eq(URLFormat::MultiDomainFormatter)
    end
  end
end
