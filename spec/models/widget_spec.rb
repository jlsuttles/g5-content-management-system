require "spec_helper"

describe Widget, vcr: VCR_OPTIONS do

  describe "#update_attributes" do
    let(:garden_widget) { Fabricate(:garden_widget, settings: [name: "foo"]) }
    let(:widget) { Fabricate(:widget, garden_widget: garden_widget) }
    let(:setting) { widget.settings.first }

    it "accepts nested attributes for settings" do
      widget.update_attributes(settings_attributes: {
        id: setting.id,
        name: "TEST"
      })
      expect(setting.name).to eq "TEST"
    end
  end

  describe "#render_show_html" do
    context "row widget" do
      let(:garden_widget) { Fabricate.build(:garden_widget, name: "Row") }
      let(:widget) { Fabricate.build(:widget, garden_widget: garden_widget) }
      let(:row_widget_show_html) { double(render: nil) }

      before { RowWidgetShowHtml.stub(new: row_widget_show_html) }

      it "calls render on RowWidgetShowHtml" do
        widget.render_show_html
        expect(row_widget_show_html).to have_received(:render)
      end
    end

    context "column widget" do
      let(:garden_widget) { Fabricate.build(:garden_widget, name: "Column") }
      let(:widget) { Fabricate.build(:widget, garden_widget: garden_widget) }
      let(:column_widget_show_html) { double(render: nil) }

      before { ColumnWidgetShowHtml.stub(new: column_widget_show_html) }

      it "calls render on ColumnWidgetShowHtml" do
        widget.render_show_html
        expect(column_widget_show_html).to have_received(:render)
      end
    end

    context "all other widgets" do
      let(:widget) { Fabricate.build(:widget) }

      it "does not escape funky characters" do
        widget.stub(:show_html) { "^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" }
        expect(widget.render_show_html).to eq widget.show_html
      end
    end
  end

  describe "#render_edit_html" do
    let(:widget) { Fabricate.build(:widget) }

    it "does not escape funky characters" do
      widget.stub(:edit_html) { "^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" }
      expect(widget.render_edit_html).to eq widget.edit_html
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
