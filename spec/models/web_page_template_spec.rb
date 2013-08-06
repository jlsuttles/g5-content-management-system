require 'spec_helper'

describe WebPageTemplate do
  let(:web_page_template) { Fabricate.build(:web_page_template) }

  it "should be a WebTemplate" do
    web_page_template.should be_kind_of(WebTemplate)
  end

  it "should return all widgets" do
    web_page_template.all_widgets.should be_a(Array)
  end
end
