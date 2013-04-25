require "spec_helper"

shared_examples_for HasSettingNavigation do
  let(:described_instance) { described_class.new }

  describe "#setting_navigation" do
    context "navigation setting exists" do
      let(:navigation) { described_instance.settings.build(name: "navigation") }
      it "finds setting with name navigation" do
        described_instance.save
        described_instance.setting_navigation.new_record?.should be_false
      end
    end
    context "navigation setting does not exist" do
      it "initializes setting with name navigation" do
        described_instance.setting_navigation.new_record?.should be_true
      end
    end
  end

  describe "#web_page_templates_to_hashes" do
    context "has no web pages" do
      it "returns an empty array" do
        described_instance.web_page_templates_to_hashes.should eq []
      end
    end
    context "has web pages" do
      let(:web_page_template) { Fabricate.build(:web_page_template) }
      before do
        described_instance.web_page_templates << web_page_template
        described_instance.save(validate: false)
      end
      it "returns hashes with to liquid defined" do
        described_instance.web_page_templates_to_hashes.sample.should be_a(HashWithToLiquid)
      end
      it "hashes have key 'display'" do
        described_instance.web_page_templates_to_hashes.sample["display"].should_not be_nil
      end
      it "hashes have key 'title'" do
        described_instance.web_page_templates_to_hashes.sample["title"].should_not be_nil
      end
      it "hashes have key 'url'" do
        described_instance.web_page_templates_to_hashes.sample["url"].should_not be_nil
      end
    end
  end
end

describe Website do
  it_behaves_like HasSettingNavigation
end
