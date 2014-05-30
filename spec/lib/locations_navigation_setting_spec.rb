require "spec_helper"

describe LocationsNavigationSetting do
  describe "#group_locations" do
    let!(:location_2) { Fabricate(:location, state: "California", city: "San Francisco") }
    let!(:location_3) { Fabricate(:location, state: "Oregon") }
    let!(:location_1) { Fabricate(:location, state: "California", city: "Los Angeles") }
    subject { LocationsNavigationSetting.new.grouped_locations }

    it "groups locations with the same state" do
      expect(subject).to eq ({
        "California" => [location_1, location_2],
        "Oregon" => [location_3]
      })
    end

    it "orders locations alphabetically by state name" do
      expect(subject.keys).to eq ["California", "Oregon"]
    end

    it "orders locations alphabetically by city name" do
      expect(subject["California"].map(&:city)).to eq ["Los Angeles", "San Francisco"]
    end
  end

  describe "#value" do
    let!(:location_2) { Fabricate(:location, state: "California", city: "San Francisco") }
    let!(:location_3) { Fabricate(:location, state: "Oregon") }
    let!(:location_1) { Fabricate(:location, state: "California", city: "Los Angeles") }
    subject { LocationsNavigationSetting.new.value }

    it "maps location names to their urls" do
      expect(subject).to eq ({
        "California" => {
          location_1.name => "location-url",
          location_2.name => "location-url"
        },
        "Oregon" => {
          location_3.name => "location-url"
        }
      })
    end
  end
end
