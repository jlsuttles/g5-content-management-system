require 'spec_helper'

describe Page do

  let(:page) { Fabricate(:page, name: "Some Name", slug: "some-name", widgets_attributes: [{name: "Widgie", url: "spec/support/widget.html"}]) }

  describe "callbacks" do
    it "should enable pages by default" do
      Page.new.disabled?.should be_false
    end
  end

  describe "scopes" do
    before do
      @disabled_page = Fabricate(:page, disabled: true)
      @page = page
    end
    context ".enabled" do
      it "should return enabled pages"do
        Page.enabled.should == [@page]
      end
    end
    context ".disabled" do
      it "should return enabled pages"do
        Page.disabled.should == [@disabled_page]
      end
    end
  end

  describe "validations" do
    let(:page) { Fabricate.build(:page, name: "Some Name", slug: "some-name", widgets_attributes: [{name: "Widgie", url: "spec/support/widget.html"}]) }

    describe "slug" do
      it do
        page.slug = "*"
        page.should be_invalid
      end
      it do
        page.slug = "somename"
        page.should be_valid
      end
      it do
        page.slug = "some name"
        page.should be_invalid
      end
      it do
        page.slug = "some-name"
        page.should be_valid
      end
      it do
        page.slug = "1name"
        page.should be_valid
      end
      it do
        page.slug = "some_name"
        page.should be_valid
      end
      it do
        page.slug = "some%name"
        page.should be_invalid
      end
      it do
        page.slug = "some.name"
        page.should be_invalid
      end
      it do
        page.slug = "some.name"
        page.save
        page.errors[:slug].should include "can only contain letters, numbers, dashes, and underscores."
      end

    end
  end

  describe "layouts" do
    it { Page.new.should respond_to :page_layout }
  end

  describe "themes" do
    it { Page.new.should respond_to :theme }
  end

  describe "widgets" do
    before do
      Widget.stub(:all_remote) { [Widget.new(name: "Widget1"), Widget.new(name: "Widget2")]}
    end

    let(:remotes) { Widget.all_remote }
    it { Page.new.should respond_to :widgets }

    it "finds all remotes" do
      page.remote_widgets.map(&:name).should eq remotes.map(&:name)
    end

    it "finds all but included widgets" do
      page.widgets << remotes.first
      page.remote_widgets.first.name.first.should_not eq "Widget1"
    end

    describe "nested attributes" do
      let(:widget) { page.widgets.first }
      it "creates a new widget" do
        widget.name.should eq "Storage List"
      end

      it "doesn't save if it's marked as destroy" do
        page = Fabricate(:page, name: "P", widgets_attributes: [{_destroy: true, name: "Widgie", url: "http://example.com"}])
        page.widgets.should be_empty
      end
    end

  end

end
