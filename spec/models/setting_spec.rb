require 'spec_helper'

describe Setting do
  let(:setting) { Fabricate(:setting) }
  describe "#validation" do
    let(:setting) { Setting.create }
    it "must have a name" do
      setting.errors[:name].should include "can't be blank"
    end
    
    it "must belong to a component" do
      setting.errors[:component].should include "can't be blank"
    end
  end
  
  describe "#categories" do
    it "is an Array" do
      setting.reload
      setting.categories.should be_an_instance_of Array
    end
  end
  
  describe "widget_attributes" do
    it "defines dynamic methods" do
      setting.should respond_to :username
    end
  end
end