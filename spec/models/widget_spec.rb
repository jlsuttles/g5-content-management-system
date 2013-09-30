require "spec_helper"

describe Widget, vcr: VCR_OPTIONS do

  describe ".all_remote" do
    let(:all_remote) { WidgetSupport.all_remote }

    it "returns 23 widgets with names, urls, and thumbails" do
      expect(all_remote).to have(23).items
      all_remote.each do |a_remote|
        expect(a_remote).to be_an_instance_of Widget
        expect(a_remote.name).to be_present
        expect(a_remote.url).to be_present
        expect(a_remote.thumbnail).to be_present
      end
    end
  end

  describe "#assign_attributes_from_url" do
    describe "any widget" do
      let(:widget) { Fabricate.build(:widget) }

      before do
        widget.send(:assign_attributes_from_url)
      end

      it "assigns a name" do
        expect(widget.name).to be_present
      end

      it "assigns a url" do
        expect(widget.url).to be_present
      end

      it "assigns a thumbnail" do
        expect(widget.thumbnail).to be_present
      end

      it "assigns show html" do
        expect(widget.html).to be_present
      end

      it "assigns edit html" do
        expect(widget.edit_form_html).to be_present
      end

      it "assigns settings" do
        expect(widget.settings).to be_present
      end

      describe "assigns settings attributes" do
        let(:setting) { widget.settings.first }

        it "assigns name" do
          expect(setting.name).to be_present
        end

        it "assigns editable" do
          expect(setting.editable).to_not be_nil
        end

        it "assigns default_value" do
          expect(setting.default_value).to_not be_nil
        end

        it "assigns categories" do
          expect(setting.categories).to_not be_nil
        end
      end
    end

    describe "when widget has stylesheets" do
      let(:widget) { Fabricate.build(:widget, url: WidgetSupport.twitter_feed.url) }

      before do
        widget.send(:assign_attributes_from_url)
      end

      it "assigns stylesheets" do
        expect(widget.stylesheets).to be_present
      end
    end

    describe "when widget has show javascript" do
      let(:widget) { Fabricate.build(:widget, url: WidgetSupport.twitter_feed.url) }

      before do
        widget.send(:assign_attributes_from_url)
      end

      it "assigns show javascript" do
        expect(widget.show_javascript).to be_present
      end
    end

    describe "when widget has lib javascripts" do
      let(:widget) { Fabricate.build(:widget, url: WidgetSupport.twitter_feed.url) }

      before do
        widget.send(:assign_attributes_from_url)
      end

      it "assigns lib javascripts" do
        expect(widget.lib_javascripts).to be_present
      end
    end

    describe "when widget has edit javascript" do
      let(:widget) { Fabricate.build(:widget, url: WidgetSupport.calls_to_action.url) }

      before do
        widget.send(:assign_attributes_from_url) end

      it "assigns edit javascript" do
        expect(widget.edit_javascript).to be_present
      end
    end

    describe "when no component is found at url" do
      let(:widget) { Fabricate.build(:widget, url: "http://google.com") }

      it "raises an error" do
        expect { widget.send(:assign_attributes_from_url) }.to raise_error(
          StandardError, "No h-g5-component found at url: #{widget.url}")
      end
    end

    describe "when OpenURI::HTTPError" do
      let(:widget) { Fabricate.build(:widget) }

      before do
        Microformats2.stub(:parse) {
          raise OpenURI::HTTPError.new("404 Object Not Found", nil)
        }
      end

      it "logs a failed request" do
        Rails.logger.should_receive(:warn).with("404 Object Not Found")
        widget.send(:assign_attributes_from_url)
      end
    end
  end

  describe "#update_attributes" do
    let(:widget) { Fabricate(:widget) }
    let(:setting) { widget.settings.first }

    it "accepts nested attributes for settings" do
      widget.update_attributes(settings_attributes: {
        id: setting.id,
        name: "TEST"
      })
      expect(setting.reload.name).to eq "TEST"
    end
  end

  describe "#liquidized_html" do
    let(:widget) { Fabricate.build(:widget) }

    it "does not escape funky characters" do
      widget.html = "^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
      expect(widget.liquidized_html).to eq widget.html
    end
  end


  describe "#create_widget_entry_if_updated" do
    let(:widget) { Fabricate(:widget) }

    context "when no widget entries exist" do
      before do
        widget.widget_entries = []
      end

      it "returns a new widget entry" do
        expect(widget.create_widget_entry_if_updated).to be_kind_of WidgetEntry
      end
    end

    context "when widget entries exist" do
      before do
        widget.widget_entries.create
      end

      it "returns a new widget entry if the widget has been updated" do
        widget.updated_at = Time.now + 1.day
        expect(widget.create_widget_entry_if_updated).to be_kind_of WidgetEntry
      end

      it "returns nil if the widget has not been updated" do
        widget.updated_at = Time.now - 1.day
        expect(widget.create_widget_entry_if_updated).to be_nil
      end
    end
  end

  describe "#set_default_calls_to_action" do

    context "calls to action widget" do
      let (:widget) { Fabricate(:widget, url: WidgetSupport.calls_to_action.url) }

      before do
        widget.set_default_calls_to_action
      end

      it "assigns the defaults" do
        widget.get_default_calls_to_action.values.each do |value|
          expect(widget.settings.map(&:value)).to include(value)
        end
      end
    end

    context "not calls to action widget" do
      let(:widget) { Fabricate(:widget) }

      before do
        widget.set_default_calls_to_action
      end

      it "does not assign the defaults" do
        widget.get_default_calls_to_action.values.each do |value|
          expect(widget.settings.map(&:value)).not_to include(value)
        end
      end
    end
  end
end
