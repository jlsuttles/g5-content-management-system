require File.dirname(__FILE__) + '/../spec_helper'

describe Location do
  before { Location.any_instance.stub(:hashed_id) { "im-an-id" }}
  let(:location) { Fabricate(:location, name: "Some Name") }

  describe "Validations" do
    it "should be valid" do
      Location.new.should be_valid
    end
  end

  describe "Paths" do
    it do
      location.urn.should eq "g5-cl-im-an-id-some-name"
    end

    it "param is urn" do
      location.to_param.should eq location.urn
    end
  end
end
