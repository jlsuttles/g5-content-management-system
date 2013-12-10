require "spec_helper"

shared_examples_for AfterUpdateSetSettingNavigation do
  let(:described_instance) { described_class.new }

  describe ".after_create" do
    it "calls #update_navigation_settings" do
      described_instance.should_receive(:update_navigation_settings)
      described_instance.save(validate: false)
    end
  end

  describe ".after_update" do
    before do
      described_instance.save(validate: false)
    end
    context "name changed" do
      it "calls #update_navigation_settings" do
        described_instance.should_receive(:update_navigation_settings)
        described_instance.update_attribute(:name, "new name")
      end
    end
    context "name did not change" do
      it "does not call #update_navigation_settings" do
        described_instance.should_not_receive(:update_navigation_settings)
        described_instance.update_attribute(:title, "new title")
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
