require 'spec_helper'

describe WebTemplate do
  before do
    # Widget.any_instance.stub(:assign_attributes_from_url) { true }
  end

  let(:web_template) { WebTemplate.create(title: "What a wonderful world", name: "Some Name", slug: "some-name", widgets_attributes: [{name: "Widgie", url: "spec/support/widget.html"}]) }

  it { web_template.slug.should eq "some-name"}

  describe "validations" do
    describe "slug" do
      it do
        web_template.slug = "*"
        web_template.should be_invalid
      end
      it do
        web_template.slug = "somename"
        web_template.should be_valid
      end
      it do
        web_template.slug = "some name"
        web_template.should be_invalid
      end
      it do
        web_template.slug = "some-name"
        web_template.should be_valid
      end
      it do
        web_template.slug = "1name"
        web_template.should be_valid
      end
      it do
        web_template.slug = "some_name"
        web_template.should be_valid
      end
      it do
        web_template.slug = "some%name"
        web_template.should be_invalid
      end
      it do
        web_template.slug = "some.name"
        web_template.should be_invalid
      end
      it do
        web_template.slug = "some.name"
        web_template.save
        web_template.errors[:slug].should include "can only contain letters, numbers, dashes, and underscores."
      end

    end
  end

  describe "layouts" do
    it { WebTemplate.new.should respond_to :web_layout }
  end

  describe "themes" do
    it { WebTemplate.new.should respond_to :web_theme }
  end

  describe "widgets" do
    before do
      Widget.stub(:all_remote) { [Widget.new(name: "Widget1"), Widget.new(name: "Widget2")]}
    end

    let(:remotes) { Widget.all_remote }
    it { WebTemplate.new.should respond_to :widgets }

    it "finds all remotes" do
      web_template.remote_widgets.map(&:name).should eq remotes.map(&:name)
    end

    it "finds all but included widgets" do
      web_template.widgets << remotes.first
      web_template.remote_widgets.first.name.first.should_not eq "Widget1"
    end

    describe "nested attributes" do
      let(:widget) { web_template.widgets.first }
      it "creates a new widget" do
        widget.name.should eq "Storage List"
      end


      it "doesn't save if it's marked as destroy" do
        web_template = WebTemplate.create(name: "P", widgets_attributes: [{_destroy: true, name: "Widgie", url: "http://example.com"}])
        web_template.widgets.should be_empty
      end
    end

  end

end
