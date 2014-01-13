require "spec_helper"

describe WebTheme, vcr: VCR_OPTIONS do

  describe ".all_remote" do
    let(:all_remote) { WebThemeSupport.all_remote }

    it "returns 5 web themes with names, urls, and thumbails" do
      expect(all_remote).to have(5).items
      all_remote.each do |a_remote|
        expect(a_remote).to be_an_instance_of WebTheme
        expect(a_remote.name).to be_present
        expect(a_remote.url).to be_present
        expect(a_remote.thumbnail).to be_present
      end
    end
  end

  describe "#assign_attributes_from_url" do
    describe "when component is found at url" do
      let(:web_theme) { Fabricate.build(:web_theme) }

      before do
        web_theme.send(:assign_attributes_from_url)
      end

      it "assigns a name" do
        expect(web_theme.name).to be_present
      end

      it "assigns a url" do
        expect(web_theme.url).to be_present
      end

      it "assigns a thumbnail" do
        expect(web_theme.thumbnail).to be_present
      end

      it "assigns primary color" do
        expect(web_theme.primary_color).to be_present
      end

      it "assigns secondary color" do
        expect(web_theme.secondary_color).to be_present
      end

      it "assigns a stylesheets" do
        expect(web_theme.stylesheets).to be_present
      end
    end

    describe "when no component is found at url" do
      let(:web_theme) { Fabricate.build(:web_theme, url: "http://google.com") }

      it "raises an error" do
        expect { web_theme.send(:assign_attributes_from_url) }.to raise_error(
          StandardError, "No h-g5-component found at url: #{web_theme.url}")
      end
    end

    describe "when OpenURI::HTTPError" do
      let(:web_theme) { Fabricate.build(:web_theme) }

      before do
        Microformats2.stub(:parse) {
          raise OpenURI::HTTPError.new("404 Object Not Found", nil)
        }
      end

      it "logs a failed request" do
        Rails.logger.should_receive(:warn).with("404 Object Not Found")
        web_theme.send(:assign_attributes_from_url)
      end
    end
  end

  describe "Colors" do
    describe "Default Colors" do
      describe "When custom colors are nil" do
        let(:web_theme) { Fabricate(:web_theme,
          custom_colors: nil,
          custom_primary_color: nil,
          custom_secondary_color: nil) }

        it { web_theme.primary_color.should eq(web_theme.colors[0]) }
        it { web_theme.secondary_color.should eq(web_theme.colors[1]) }
      end

      describe "When custom colors are present" do
        let(:web_theme) { Fabricate(:web_theme,
          custom_colors: nil,
          custom_primary_color: "#custom-primary",
          custom_secondary_color: "#custom-secondary") }

        it { web_theme.primary_color.should eq(web_theme.colors[0]) }
        it { web_theme.secondary_color.should eq(web_theme.colors[1]) }
      end
    end

    describe "Custom Colors" do
      describe "When custom colors are nil" do
        let(:web_theme) { Fabricate(:web_theme,
          custom_colors: true,
          custom_primary_color: nil,
          custom_secondary_color: nil) }

        it { web_theme.primary_color.should eq(web_theme.colors[0]) }
        it { web_theme.secondary_color.should eq(web_theme.colors[1]) }
      end

      describe "When custom colors are present" do
        let(:web_theme) { Fabricate(:web_theme,
          custom_colors: true,
          custom_primary_color: "#custom-primary",
          custom_secondary_color: "#custom-secondary") }

        it { web_theme.primary_color.should eq "#custom-primary" }
        it { web_theme.secondary_color.should eq "#custom-secondary" }
      end
    end
  end
end
