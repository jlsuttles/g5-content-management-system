require File.dirname(__FILE__) + '/../spec_helper'

describe Location do
  describe "validations" do
    it "should have a valid fabricator" do
      Fabricate.build(:location).should be_valid
    end
    it "should require uid" do
      Fabricate.build(:location, uid: "").should_not be_valid
    end
    it "should not require urn on new records" do
      Fabricate.build(:location, urn: "").should be_valid
    end
    it "should require name" do
      Fabricate.build(:location, name: "").should_not be_valid
    end
  end
  describe "#urn" do
    let(:location) { Fabricate(:location) }
    it "sets on save" do
      location.urn.should match /g5-cl-\d+-/
    end
  end
  describe "#website" do
    let(:location) { Fabricate(:location) }
    it "creates a website on create" do
      expect { location }.to change(Website, :count).by(1)
    end
  end
end
