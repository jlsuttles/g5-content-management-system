require "spec_helper"

describe RowWidgetShowHtml do
  let!(:garden_widget) { Fabricate(:garden_widget, name: "row") }
  let!(:row_widget) { Fabricate(:widget, garden_widget: garden_widget) }
  let(:row_widget_show_html) { described_class.new(row_widget) }

  describe "#render" do
    describe "parsing" do
      let(:liquid_parse) { double(render: nil) }

      before do
        Liquid::Template.stub(parse: liquid_parse)
        Nokogiri.stub(parse: double(to_html: nil))
        row_widget_show_html.render
      end

      it "parses widget as a liquid template" do
        expect(liquid_parse).to have_received(:render).with("widget" => row_widget)
      end

      it "parses the liquid template with Nokogiri" do
        expect(Nokogiri).to have_received(:parse)
      end
    end
  end
end
