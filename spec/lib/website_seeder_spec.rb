require "spec_helper"

describe WebsiteSeeder do
  let!(:client) { Fabricate(:client) }
  let!(:location) { Fabricate(:location) }
  let(:website) { Fabricate(:website) }
  let(:defaults) { YAML.load_file("#{Rails.root}/config/defaults.yml")["website"] }
  let(:seeder) { WebsiteSeeder.new(location) }

  def setting_value_for(name)
    website.settings.where(name: name).first.value
  end

  describe "#seed" do
    let(:client_services) { ClientServices.new }

    before { location.stub(create_website: website) }
    subject { seeder.seed }

    it "creates a website for the location" do
      location.should_receive(:create_website).and_return(website)
      subject
    end

    it "returns a website" do
      expect(subject).to eq(website)
    end

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

    describe "template creation" do
      after { subject }

      it "creates a website template" do
        seeder.should_receive(:create_website_template)
      end

      it "creates a web home template" do
        seeder.should_receive(:create_web_home_template)
      end

      it "creates a web page template" do
        seeder.should_receive(:create_web_page_templates)
      end
    end
  end

  describe "#create_website_template" do
    let(:instructions) { defaults["website_template"] }
    let!(:website_template) { Fabricate(:website_template) }

    subject { seeder.create_website_template(website, instructions) }

    context "a valid website" do
      before { website.stub(create_website_template: website_template) }
      after  { subject }

      it "creates a website template for the website" do
        website.should_receive(:create_website_template)
      end

      it "creates a web layout for the template" do
        website_template.should_receive(:create_web_layout)
      end

      it "creates a web theme for the template" do
        website_template.should_receive(:create_web_theme)
      end

      it "creates drop targets" do
        seeder.should_receive(:create_drop_targets).with(website_template, instructions["drop_targets"])
      end
    end

    context "no website" do
      let(:website) { nil }

      it { should be_nil }
    end
  end

  describe "#create_web_home_template" do
    let(:instructions) { defaults["web_home_template"] }
    let!(:web_home_template) { Fabricate(:web_home_template) }

    subject { seeder.create_web_home_template(website, instructions) }

    context "a valid website" do
      before { website.stub(create_web_home_template: web_home_template) }
      after  { subject }

      it "creates a web home template for the website" do
        website.should_receive(:create_web_home_template)
      end

      it "creates drop targets" do
        seeder.should_receive(:create_drop_targets).with(web_home_template, instructions["drop_targets"])
      end
    end

    context "no website" do
      let(:website) { nil }

      it { should be_nil }
    end
  end

  describe "#create_web_page_templates" do
    let(:instructions) { [defaults["web_page_templates"].first] }
    let!(:web_page_template) { Fabricate(:web_page_template) }

    subject { seeder.create_web_page_templates(website, instructions) }

    context "a valid website" do
      before { website.web_page_templates.stub(create: web_page_template) }
      after  { subject }

      it "creates a web page template for each instruction" do
        website.web_page_templates.should_receive(:create)
      end

      it "creates drop targets" do
        seeder.should_receive(:create_drop_targets).
          with(web_page_template, instructions.first["drop_targets"])
      end
    end

    context "no website" do
      let(:website) { nil }

      it { should be_nil }
    end
  end

  describe "#create_drop_targets" do
    let!(:web_template) { Fabricate(:website_template) }
    let!(:drop_target) { Fabricate(:drop_target) }
    let(:instructions) { defaults["web_page_templates"].first["drop_targets"] }

    subject { seeder.create_drop_targets(web_template, instructions) }

    context "a valid website" do
      before { web_template.drop_targets.stub(create: drop_target) }
      after  { subject }

      it "creates a drop template for each instruction" do
        web_template.drop_targets.should_receive(:create)
      end

      it "creates drop targets" do
        seeder.should_receive(:create_widgets).
          with(drop_target, instructions.first["widgets"])
      end
    end

    context "no web template" do
      let(:web_template) { nil }

      it { should be_nil }
    end
  end

  describe "#create_widgets" do
    let(:instructions) { defaults["web_page_templates"].first["drop_targets"].first["widgets"] }
    let(:drop_target) { Fabricate.build(:drop_target) }
    let(:widget) { Fabricate.build(:widget) }

    subject { seeder.create_widgets(drop_target, instructions) }

    context "a valid website" do
      before { drop_target.widgets.stub(create: widget) }
      after  { subject }

      it "creates a drop template for each instruction" do
        drop_target.widgets.should_receive(:create)
      end
    end

    context "no web template" do
      let(:drop_target) { nil }

      it { should be_nil }
    end
  end
end
