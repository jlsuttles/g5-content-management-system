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

  describe "#type_for_route" do
    it "should use its own type" do
      web_page_template.type_for_route.should == web_page_template.type
    end  

    describe "web_page_template subclass" do
      it "should use the parent class" do
        floorplans_and_rates_template = Fabricate.build(:floorplans_and_rates_template)
        floorplans_and_rates_template.type_for_route.should == web_page_template.type
      end  
    end
  end  
  
  describe "WebPageTemplate default widgets" do
    before do
      WebPageTemplate.any_instance.stub(build_widget_url: "spec/support/widget.html")
      WebHomeTemplate.any_instance.stub(default_widgets: ["storage-list"])
      @web_home_template = Fabricate(:web_home_template)
    end
    it "builds default widgets for WebPageTemplate subclasses" do
      @web_home_template.widgets.map(&:name).should include("Storage List")
    end
    it "assigns the widgets to the 'main' section" do
      @web_home_template.main_widgets.count.should ==
      @web_home_template.widgets.count
    end
  end
end
