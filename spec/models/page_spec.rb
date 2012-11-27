require 'spec_helper'

describe Page do
  describe "layouts" do
    it { Page.new.should respond_to :layout }
  end
  
  describe "themes" do
    it { Page.new.should respond_to :theme }
  end

  describe "widgets" do
    it { Page.new.should respond_to :widgets }
    describe "nested attributes" do
      before { Widget.any_instance.stub(:get_html) { "<div class='widget'><h1>THIS IS THE HTML</h1></div>"}}
      let(:page) { Page.create(name: "P", widgets_attributes: [{name: "Widgie", url: "http://example.com"}]) }
      let(:widget) { page.widgets.first }
      it "creates a new widget" do
        widget.name.should eq "Widgie"
      end
      
      it { widget.html.should eq "<h1>THIS IS THE HTML</h1>" }
      
      it "doesn't save if it's marked as destroy" do
        page = Page.create(name: "P", widgets_attributes: [{_destroy: true, name: "Widgie", url: "http://example.com"}])
        page.widgets.should be_empty
      end
    end
    
  end

end
