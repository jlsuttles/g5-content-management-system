require 'spec_helper'

describe WidgetEntry do
  let(:widget) { Fabricate(:widget) }
  let(:widget_entry) { WidgetEntry.create(widget_id: widget.id) }

  it "saves widget html before create" do
    widget_entry.content.should == widget.html
  end
end
