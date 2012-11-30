require 'spec_helper'

describe Widget do
  let(:widget) { Widget.create(name: "remote", url: "http://g5-widget-garden.herokuapp.com/components/storage-list", page_id: 1, section: "main") }
  
  it { Widget.in_section("main").should include widget }
  
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
  
end
