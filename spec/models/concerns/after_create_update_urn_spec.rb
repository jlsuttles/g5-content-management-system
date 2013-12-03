require "spec_helper"

shared_examples_for AfterCreateUpdateUrn do
  let(:described_instance) { described_class.new }

  it "calls #update_urn after save" do
    described_instance.should_receive(:update_urn)
    described_instance.save(validate: false)
  end

  describe ".set_urn_prefix" do
    before do
      @original_urn_prefix = described_class.urn_prefix
    end
    after do
      described_class.set_urn_prefix(@original_urn_prefix)
    end

    it "sets .urn_prefix" do
      described_class.set_urn_prefix("foo")
      described_class.urn_prefix.should eq("foo")
    end
  end
end

describe Website do
  it_behaves_like AfterCreateUpdateUrn
end
