require 'spec_helper'

describe WidgetEntry do
  let(:widget_entry) { Fabricate.build(:widget_entry) }
  let(:widget) { widget_entry.widget }

  it "saves widget html before create" do
    widget_entry.content.should == widget.html
  end
end
