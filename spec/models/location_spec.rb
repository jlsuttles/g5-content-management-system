require File.dirname(__FILE__) + '/../spec_helper'

describe Location do
  it "should be valid" do
    Location.new.should be_valid
  end
  
  it "adds a page on creation" do
    expect { Location.create }.to change(Page, :count).by(1)
  end
end
