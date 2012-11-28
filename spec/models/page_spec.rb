require 'spec_helper'

describe Page do
  let(:page) { Page.create(name: "P", widgets_attributes: [{name: "Widgie", url: "http://example.com"}]) }
  before { Widget.any_instance.stub(:get_html) { "<div class='widget'><h1>THIS IS THE HTML</h1></div>"}}
  
  describe "layouts" do
    it { Page.new.should respond_to :layout }
  end
  
  describe "themes" do
    it { Page.new.should respond_to :theme }
  end

  describe "widgets" do
    before do
      Widget.stub(:all_remote) { [Widget.new(name: "Widget1"), Widget.new(name: "Widget2")]}
    end
    
    let(:remotes) { Widget.all_remote }
    it { Page.new.should respond_to :widgets }
    
    it "finds all remotes" do
      page.remote_widgets.map(&:name).should eq remotes.map(&:name)
    end
    
    it "finds all but included widgets" do
      page.widgets << remotes.first
      page.remote_widgets.first.name.should_not eq "Widget1"
    end
    
    describe "nested attributes" do
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
