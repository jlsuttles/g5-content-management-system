require 'spec_helper'

describe Widget do
  before do
    stub_const("ENV", {"WIDGET_GARDEN_URL" => "spec/support/widgets.html"})
  end
  let(:widget) { Fabricate(:widget) }

  it { Widget.in_section("aside").should include widget }

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

  describe "assign_attributes_from_url" do
    it { widget.name.should eq "Storage List" }
    it { widget.stylesheets.should have(1).thing }
    it { widget.javascripts.should have(1).things }
    it { widget.edit_form_html.should eq "I'm an edit form!" }
    it { widget.html.should include "I'm a show page!" }
    it { widget.thumbnail.should eq "http://g5-widget-garden.herokuapp.com/static/components/storage-list/images/thumbnail.png"}
  end

  describe "#configurations" do
    let(:setting) { widget.settings.first }
    it "creates one" do
      expect { widget }.to change(Setting, :count).by(1)
    end

    it "assigns a name" do
      setting.name.should eq "Feed"
    end
    it "assigns categories" do
      setting.categories.should eq ["Instance"]
    end

    it "assigns widget attributes to the settings" do
      expect { widget }.to change(WidgetAttribute, :count).by(2)
    end
  end

  describe "updating widget attributes" do
    it "updates with nested attributes" do
      attribute = widget.widget_attributes.first
      widget.update_attributes(widget_attributes_attributes: {
        id: attribute.id,
        value: "TEST"
      })
      attribute.reload
      attribute.value.should eq "TEST"
    end
  end

  describe "dynamic setting methods" do
    it "makes a dynamic method" do
      widget.should respond_to :feed
    end
    it "sets the value to an association" do
      widget.feed.should eq widget.settings.first
    end
    it "lists the methods" do
      widget.singleton_methods.should include :feed
    end
  end

  describe "#liquidized_html" do
    it "does not escape funky characters" do
      widget.html = "^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$"
      widget.liquidized_html.should == widget.html
    end
  end

  describe "#create_widget_entry_if_updated" do
    context "when no widget entries exist" do
      before do
        widget.widget_entries = []
      end
      it "returns a new widget entry" do
        widget.create_widget_entry_if_updated.should be_kind_of WidgetEntry
      end
    end
    context "when widget entries exist" do
      before do
        widget.widget_entries.create
      end
      it "returns a new widget entry if the widget has been updated" do
        widget.updated_at = Time.now + 1.day
        widget.create_widget_entry_if_updated.should be_kind_of WidgetEntry
      end
      it "returns nil if the widget has not been updated" do
        widget.updated_at = Time.now - 1.day
        widget.create_widget_entry_if_updated.should be_nil
      end
    end
  end

  describe "#set_default_calls_to_action" do
    let (:cta_widget) { Fabricate(:widget, url: "spec/support/calls_to_action_widget.html")}

    it "assigns the defaults" do
      first_default = CallToAction.default_calls_to_action.first
      widget_attribute_values = cta_widget.widget_attributes.map(&:value)
      CallToAction.default_calls_to_action.values.each do |value|
        widget_attribute_values.should include(value)
      end
    end
  end
end
