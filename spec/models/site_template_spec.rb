require 'spec_helper'

describe SiteTemplate do
  let(:template) { Fabricate(:site_template) }

  its(:sections) { should eq ['header', 'aside', 'footer']}
  its(:type) { should eq "SiteTemplate" }
  its(:header_widgets) { should eq [] }
  its(:aside_widgets) { should eq [] }
  its(:footer_widgets) { should eq [] }

  describe "stylesheets" do
    it { template.stylesheets.should have(3).things }

    it "has compiled stylesheets" do
      template.compiled_pages_stylesheets.should have(1).thing
    end
  end

  describe "javascripts" do
    it "has javascript files" do
      template.javascripts.should have(2).things
    end
  end

  describe "Colors" do
    it { template.primary_color.should eq nil }
    it { template.secondary_color.should eq nil }
    describe "Custom" do
      before { template.location.stub(:custom_colors?) { true } }
      it { template.primary_color.should eq "#111111" }
      it { template.secondary_color.should eq "#222222" }
    end

    describe "Theme" do
      before { template.theme.stub(:primary_color) { "#999999" }}
      it do
        template.theme.stub(:primary_color) { "#999999" }
        template.primary_color.should eq "#999999"
      end
      it do
        template.theme.stub(:secondary_color) { "#666666" }
        template.secondary_color.should eq "#666666"
      end
    end
  end

end
