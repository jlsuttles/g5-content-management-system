require File.dirname(__FILE__) + '/../spec_helper'

describe Location do
  let(:location) { Location.create(name: "Example") }
  it "should be valid" do
    Location.new.should be_valid
  end
  
  it "adds a page on creation" do
    expect { location }.to change(Page, :count).by(2)
  end
  
  it "doesn't count template as a page" do
    template = Page.create(location_id: location.id, name: "Template", template: true)
    location.pages.should_not include template
  end
  
  it "has a template as a page" do
    location.site_template.should_not be_blank
  end
  
end

