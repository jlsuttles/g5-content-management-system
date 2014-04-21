require "spec_helper"

describe WebsiteSeeder do
  let!(:client) { Fabricate(:client) }
  let!(:location) { Fabricate(:location) }
  let(:seeder) { WebsiteSeeder.new(location) }

  def setting_value_for(name)
    website.settings.where(name: name).first.value
  end

  describe "#seed" do
    let(:website) { Fabricate(:website) }
    let(:client_services) { ClientServices.new }

    before { location.stub(create_website: website) }
    subject { seeder.seed }

    it { should eq(website) }

    describe "setting creation" do
      before { subject }

      it "creates settings for the website" do
        expect(setting_value_for("client_url")).to eq(client_services.client_url)
        expect(setting_value_for("client_location_urns")).to eq(client_services.client_location_urns)
        expect(setting_value_for("client_location_urls")).to eq(client_services.client_location_urls)
        expect(setting_value_for("location_urn")).to eq(location.urn)
        expect(setting_value_for("location_url")).to eq(location.domain)
        expect(setting_value_for("location_street_address")).to eq(location.street_address)
        expect(setting_value_for("location_city")).to eq(location.city)
        expect(setting_value_for("location_state")).to eq(location.state)
        expect(setting_value_for("location_postal_code")).to eq(location.postal_code)
        expect(setting_value_for("phone_number")).to eq(location.phone_number)
        expect(setting_value_for("available_garden_widgets")).to eq(GardenWidgetsSetting.new.value)
      end
    end
  end
end
