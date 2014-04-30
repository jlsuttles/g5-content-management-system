require "spec_helper"

describe SingleDomain do
  describe "#url_formatter_class" do
    before { Fabricate(:client, type: "SingleDomain") }

    it "returns the correct formatter" do
      expect(Client.first.url_formatter_class).to eq(URLFormat::SingleDomainFormatter)
    end
  end
end
