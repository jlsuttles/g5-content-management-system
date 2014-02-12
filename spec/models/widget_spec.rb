require "spec_helper"

describe Widget, vcr: VCR_OPTIONS do

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

  describe "#render_show_html" do
    let(:widget) { Fabricate.build(:widget) }

    it "does not escape funky characters" do
      widget.html = "^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
      expect(widget.render_show_html).to eq widget.html
    end
  end

  describe "#render_edit_html" do
    let(:widget) { Fabricate.build(:widget) }

    it "does not escape funky characters" do
      widget.html = "^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
      expect(widget.render_edit_html).to eq widget.html
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
end
