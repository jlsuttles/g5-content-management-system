require 'spec_helper'

describe WidgetEntryDecorator do
  let(:widget_entry) { Fabricate.build(:widget_entry) }
  let(:decorated_widget_entry) { WidgetEntryDecorator.decorate(widget_entry) }

  describe "#name" do
    it "should include the widget's name" do
      decorated_widget_entry.name.should include widget_entry.widget.name
    end
  end

  describe "#summary" do
    it "should include the widget's name" do
      decorated_widget_entry.summary.should include widget_entry.widget.name
    end
  end

  describe "#author_name" do
    it "should be G5 Client Hub" do
      decorated_widget_entry.author_name.should eq "G5 Client Hub"
    end
  end

  describe "#categories" do
    it "should include the last word the widget name" do
      widget_name_last_word = widget_entry.widget_name.split.last.downcase
      decorated_widget_entry.categories.should include widget_name_last_word
    end
  end
end
