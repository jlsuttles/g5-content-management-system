require 'spec_helper'

describe WidgetEntry do
  let(:widget_entry) { Fabricate.build(:widget_entry) }
  let(:widget) { widget_entry.widget }

  describe "filters" do
    context "before_create" do
      it "saves widget html" do
        widget_entry.content.should == widget.html
      end
    end
  end

  describe "#widget_name" do
    context "widget is nil" do
      it "returns nil" do
        WidgetEntry.new.widget_name.should be_nil
      end
    end
    context "widget is present" do
      it "returns widget's name" do
        widget_entry.widget_name.should eq widget.name
      end
    end
  end

  describe "#widget_liquidized_html" do
    context "widget is nil" do
      it "returns nil" do
        WidgetEntry.new.widget_liquidized_html.should be_nil
      end
    end
    context "widget is present" do
      it "returns widget's liquidized_html" do
        widget_entry.widget.stub(:html).and_return("<div></div>")
        widget_entry.widget_liquidized_html.should eq widget.liquidized_html
      end
    end
  end
end
