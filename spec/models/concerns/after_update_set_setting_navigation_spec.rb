require "spec_helper"

shared_examples_for AfterUpdateSetSettingNavigation do
  let(:described_instance) { described_class.new }

  describe ".after_create" do
    it "calls #set_setting_navigation" do
      described_instance.should_receive(:set_setting_navigation)
      described_instance.save(validate: false)
    end
  end

  describe ".after_update" do
    before do
      described_instance.save(validate: false)
    end
    context "title changed" do
      it "calls #set_setting_navigation" do
        described_instance.should_receive(:set_setting_navigation)
        described_instance.update_attribute(:title, "new title")
      end
    end
    context "title did not change" do
      it "does not call #set_setting_navigation" do
        described_instance.should_not_receive(:set_setting_navigation)
        described_instance.update_attribute(:name, "new name")
      end
    end
  end
end

describe WebTemplate do
  it_behaves_like AfterUpdateSetSettingNavigation
end

describe WebsiteTemplate do
  it_behaves_like AfterUpdateSetSettingNavigation
end

describe WebHomeTemplate do
  it_behaves_like AfterUpdateSetSettingNavigation
end

describe WebPageTemplate do
  it_behaves_like AfterUpdateSetSettingNavigation
end
