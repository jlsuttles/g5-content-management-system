require File.dirname(__FILE__) + '/../spec_helper'

describe Client do
  describe "validations" do
    it "should have a valid fabricator" do
      Fabricate.build(:client).should be_valid
    end
    it "should require uid" do
      Fabricate.build(:client, uid: "").should_not be_valid
    end
    it "should require name" do
      Fabricate.build(:client, name: "").should_not be_valid
    end
  end
end
