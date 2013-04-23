require "spec_helper"

shared_examples_for ToParamUrn do
  let(:described_instance) { described_class.new }

  it "calls urn for to_param" do
    described_instance.should_receive(:urn)
    described_instance.to_param
  end
end

describe Location do
  it_behaves_like ToParamUrn
end

describe Website do
  it_behaves_like ToParamUrn
end
