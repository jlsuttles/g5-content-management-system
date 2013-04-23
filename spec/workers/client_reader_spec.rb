require 'spec_helper'

describe ClientReader do

  describe "#perform" do
    let(:perform) { ClientReader.perform("spec/support/client.html") }

    it "creates 1 client" do
      expect { perform }.to change(Client, :count).by(1)
    end
    it "creates 2 locations" do
      expect { perform }.to change(Location, :count).by(2)
    end

    describe "WebTemplates" do
      it "creates a WebSiteTemplate " do
        expect { perform }.to change(WebsiteTemplate, :count).by(2)
      end
      it "creates a WebHomeTemplate" do
        expect { perform }.to change(WebHomeTemplate, :count).by(2)
      end
    end

    describe "default pages" do
      before do
        perform
      end
      it "configures default pages" do
        Website::DEFAULT_WEB_PAGE_TEMPLATES.each do |template|
          WebPageTemplate.where(name: template).count.should == 2
        end
      end
      it "disables the pages not needed by all clients" do
          WebPageTemplate.disabled.map(&:name).uniq.should =~ Website::DISABLED_DEFAULT_WEB_PAGE_TEMPLATES
      end
    end
  end
end
