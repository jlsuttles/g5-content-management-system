require "spec_helper"

shared_examples_for HasSettingLocationsNavigation do
  let(:described_instance) { described_class.new }

  describe "#update_locations_navigation_setting" do
    before { Location.any_instance.stub(:update_locations_navigation_settings) }
    before { described_instance.save(validate: false) }
    let!(:location) { Fabricate(:location) }
    let!(:setting) { Fabricate(:setting, owner: described_instance, name: "locations_navigation") }

    it "updates settings" do
      expect { described_instance.update_locations_navigation_setting }.to change(setting, :value)
    end
  end
end

describe Website do
  it_behaves_like HasSettingLocationsNavigation
end
