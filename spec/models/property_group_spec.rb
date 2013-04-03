require 'spec_helper'

describe PropertyGroup do
  let(:property_group) { Fabricate(:property_group) }
  describe "#validation" do
    let(:property_group) { PropertyGroup.create }
    it "must have a name" do
      property_group.errors[:name].should include "can't be blank"
    end

    it "must belong to a component" do
      property_group.errors[:component].should include "can't be blank"
    end
  end

  describe "#categories" do
    it "is an Array" do
      property_group.reload
      property_group.categories.should be_an_instance_of Array
    end
  end

  describe "widget_attributes" do
    it "defines dynamic methods" do
      property_group.should respond_to :username
    end
  end
end
