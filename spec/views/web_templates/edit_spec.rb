require 'spec_helper'

describe "web_templates/edit" do
  context "rendered with WebsiteTemplate" do
    let(:website) { Fabricate(:website) }
    let(:website_template) { Fabricate(:website_template) }
    before do
      assign(:website, website)
      assign(:web_template, website_template)
    end
    describe "layout" do
      let(:web_layout1) { Fabricate(:web_layout) }
      let(:web_layout2) { Fabricate(:web_layout) }
      before do
        website_template.web_layout = web_layout2
        WebLayout.stub(:all_remote) { [web_layout1, web_layout2] }
        render
      end
      it "current is selected" do
        css_selector = "input[type=radio][checked=checked][id*=web_layout]"
        input_element = Nokogiri::HTML(rendered).at_css(css_selector)
        input_element.attr("value").should eq web_layout2.url
      end
    end
    describe "theme" do
      let(:web_theme1) { Fabricate(:web_theme) }
      let(:web_theme2) { Fabricate(:web_theme) }
      before do
        website_template.web_theme = web_theme2
        WebTheme.stub(:all_remote) { [web_theme1, web_theme2] }
        render
      end
      it "current is selected" do
        css_selector = "input[type=radio][checked=checked][id*=web_theme]"
        input_element = Nokogiri::HTML(rendered).at_css(css_selector)
        input_element.attr("value").should eq web_theme2.url
      end
    end
  end
end
