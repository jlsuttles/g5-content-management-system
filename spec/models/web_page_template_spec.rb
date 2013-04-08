require 'spec_helper'

describe WebPageTemplate do
  let(:web_page_template) { Fabricate.build(:web_page_template) }
  it "should be a WebTemplate" do
    web_page_template.should be_kind_of(WebTemplate)
  end
  it "should have a main section" do
    web_page_template.sections.should include "main"
  end
  it "should return all widgets" do
    web_page_template.all_widgets.should be_a(Array)
  end
  it "should have a url string" do
    web_page_template.url.should be_a(String)
  end
  it "should have an alt string" do
    web_page_template.alt.should be_a(String)
  end
  it "should have a display boolean" do
    web_page_template.display.should be_true
  end
end
