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

  describe "get HTML" do
    it { widget.html.should include "storage-list widget" }
  end
  
  describe "stylesheets" do
    it "has 1 stylesheet" do
      widget.stylesheets.should have(1).thing
    end
  end
  
end
