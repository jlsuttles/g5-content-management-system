require "spec_helper"

shared_examples_for HasSettingNavigation do
  let!(:client) { Fabricate(:client) }
  let(:described_instance) { described_class.new }

  describe "#navigation_settings" do
    context "navigation setting exists" do
      let(:navigation) { described_instance.settings.build(name: "navigation") }
      it "finds setting with name navigation" do
        described_instance.save
        navigation.save
        described_instance.navigation_settings.should be_present
      end
    end
    context "navigation setting does not exist" do
      it "initializes setting with name navigation" do
        described_instance.save
        described_instance.navigation_settings.should be_present
      end
    end
  end

  describe "#navigateable_web_templates_to_hashes" do
    context "has no web pages" do
      it "returns an empty Hash" do
        described_instance.navigateable_web_templates_to_hashes.should eq({})
      end
    end
    context "has web pages" do
      let!(:web_page_template) { Fabricate(:web_page_template, website: described_instance) }
      before do
        @result = described_instance.navigateable_web_templates_to_hashes
      end

      it "uses web template id string as key" do
        @result.keys.first.should eq web_page_template.id.to_s
      end
      it "returns hashes with to liquid defined" do
        @result.values.sample.should be_a(HashWithToLiquid)
      end
      it "hashes have key 'display'" do
        @result.values.first["display"].should_not be_nil
      end
      it "hashes have key 'name'" do
        @result.values.sample["name"].should_not be_nil
      end
      it "hashes have key 'url'" do
        @result.values.sample["url"].should_not be_nil
      end
    end
  end
end

describe Website do
  it_behaves_like HasSettingNavigation
end
