require "spec_helper"

describe WebLayout, vcr: VCR_OPTIONS do

  describe ".all_remote" do
    let(:all_remote) { WebLayoutSupport.all_remote }

    it "returns 6 web layouts with names, urls, and thumbails" do
      expect(all_remote).to have(6).items
      all_remote.each do |a_remote|
        expect(a_remote).to be_an_instance_of WebLayout
        expect(a_remote.name).to be_present
        expect(a_remote.url).to be_present
        expect(a_remote.thumbnail).to be_present
      end
    end
  end

  describe "#assign_attributes_from_url" do
    describe "when component is found at url" do
      let(:web_layout) { Fabricate.build(:web_layout) }

      before do
        web_layout.send(:assign_attributes_from_url)
      end

      it "assigns a name" do
        expect(web_layout.name).to be_present
      end

      it "assigns a url" do
        expect(web_layout.url).to be_present
      end

      it "assigns a thumbnail" do
        expect(web_layout.thumbnail).to be_present
      end

      it "assigns a html" do
        expect(web_layout.html).to be_present
      end

      describe "when layout has stylesheet" do
        let(:web_layout) { Fabricate.build(:web_layout, url: WebLayoutSupport.aside_first_sidebar_left.url) }

        before do
          web_layout.send(:assign_attributes_from_url)
        end

        it "assigns stylesheets" do
          expect(web_layout.stylesheets).to be_present
        end
      end
    end

    describe "when no component is found at url" do
      let(:web_layout) { Fabricate.build(:web_layout, url: "http://google.com") }

      it "raises an error" do
        expect { web_layout.send(:assign_attributes_from_url) }.to raise_error(
          StandardError, "No h-g5-component found at url: #{web_layout.url}")
      end
    end

    describe "when OpenURI::HTTPError" do
      let(:web_layout) { Fabricate.build(:web_layout) }

      before do
        Microformats2.stub(:parse) {
          raise OpenURI::HTTPError.new("404 Object Not Found", nil)
        }
      end

      it "logs a failed request" do
        Rails.logger.should_receive(:warn).with("404 Object Not Found")
        web_layout.send(:assign_attributes_from_url)
      end
    end
  end
end
