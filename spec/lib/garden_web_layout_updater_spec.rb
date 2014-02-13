require "spec_helper"

describe GardenWebLayoutUpdater do
  let(:updater) { GardenWebLayoutUpdater.new }
  let(:gardener) { GardenWebLayout }

  describe "#update_all" do
    describe "when a new layout is added to the garden" do
      it "creates new GardenWebLayout" do
        gardener.stub(:garden_url) { "spec/support/garden_web_layout_updater/new.html" }
        expect { updater.update_all }.to change { gardener.count }.by(1)
      end
    end

    describe "when a layout is updated in the garden" do
      let(:garden_web_layout) { Fabricate(:garden_web_layout, url: "http://layout-garden.com/layout-test") }

      it "updates GardenWebLayout with same URL" do
        gardener.stub(:garden_url) { "spec/support/garden_web_layout_updater/updated.html" }
        expect { updater.update_all }.to change { garden_web_layout.reload.name }.to("Updated Garden Layout")
      end
    end

    describe "when a layout is removed from the garden" do
      let!(:garden_web_layout) { Fabricate(:garden_web_layout, url: "http://layout-garden.com/layout-test") }

      it "destroys GardenWebLayout with same URL if not in use" do
        gardener.stub(:garden_url) { "spec/support/garden_web_layout_updater/removed.html" }
        expect { updater.update_all }.to change { gardener.count }.by(-1)
      end

      it "does not destroy GardenWebLayout with same URL if it is in use" do
        Fabricate(:web_layout, garden_web_layout: garden_web_layout)
        gardener.stub(:garden_url) { "spec/support/garden_web_layout_updater/removed.html" }
        expect { updater.update_all }.not_to change { gardener.count }
      end
    end
  end

  describe "#update" do
    let(:garden_web_layout) { Fabricate(:garden_web_layout, url: "spec/support/garden_web_layout_updater/layout-test/updated.html") }

    before do
      updater.update(garden_web_layout)
    end

    it "sets url" do
      expect(garden_web_layout.url).to eq "http://layout-garden.com/layout-test"
    end

    it "sets name" do
      expect(garden_web_layout.name).to eq "Updated Garden Layout"
    end

    it "sets thumbnail" do
      expect(garden_web_layout.thumbnail).to eq "http://layout-garden.com/layout-test/images/thumbnail.png"
    end

    it "sets html" do
      expect(garden_web_layout.html).to eq "<div class=\"layout-test layout\">\n      </div>"
    end

    it "sets stylesheets" do
      expect(garden_web_layout.stylesheets).to eq ["http://layout-garden.com/layout-test/stylesheets/layout-test.css"]
    end
  end
end
