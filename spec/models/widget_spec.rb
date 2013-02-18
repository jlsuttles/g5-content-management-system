require 'spec_helper'

describe Widget do
  before do
    stub_const("Widget::WIDGET_GARDEN_URL", "spec/support/widgets.html")
  end
  let(:widget) { Fabricate(:widget) }
  
  it { Widget.in_section("aside").should include widget }
  
  describe "remote" do
    let(:remotes) { Widget.all_remote }
    it "has many remote widgets" do
      remotes.should have_at_least(8).things
    end
    
    describe "remote to new" do
      let(:remote) { remotes.first }

      it { remote.should be_an_instance_of Widget }
      it { remote.name.should_not be_blank }
      it { remote.url.should_not  be_blank }
    end
  end
  
  describe "assign_attributes_from_url" do
    it { widget.name.should eq "Storage List" }
    it { widget.stylesheets.should have(1).thing }
    it { widget.javascripts.should have(1).things }
    it { widget.edit_form_html.should eq "I'm an edit form!" }
    it { widget.html.should include "storage-list widget" }
    it { widget.thumbnail.should eq "http://g5-widget-garden.herokuapp.com/static/components/storage-list/images/thumbnail.png"}
  end
  
  describe "#configurations" do
    let(:setting) { widget.settings.first }
    it "creates one" do
      expect { widget }.to change(Setting, :count).by(1)
    end
    
    it "assigns a name" do
      setting.name.should eq "Feed"
    end
    it "assigns categories" do
      setting.categories.should eq ["Instance"]
    end
  end

end
