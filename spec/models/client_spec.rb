require File.dirname(__FILE__) + '/../spec_helper'

describe Client do
  def load_yaml(file)
    YAML.load_file("#{Rails.root}/config/#{file}")
  end

  describe "validations" do
    it "should have a valid fabricator" do
      Fabricate.build(:client).should be_valid
    end
    it "should require uid" do
      Fabricate.build(:client, uid: "").should_not be_valid
    end
    it "should require name" do
      Fabricate.build(:client, name: "").should_not be_valid
    end
  end

  describe "#website_defaults" do
    let!(:client) { Fabricate(:client, vertical: vertical) }

    before do
      WEBSITE_DEFAULTS_APARTMENTS = load_yaml("website_defaults_apartments.yml")
    end

    subject { client.website_defaults }

    context "Self Storage" do
      let(:vertical) { "Self-Storage" }

      it "loads the appropriate defaults" do
        expect(subject).to eq load_yaml("website_defaults_self_storage.yml")
      end
    end

    context "Apartments" do
      let(:vertical) { "Apartments" }

      it "loads the appropriate defaults" do
        expect(subject).to eq load_yaml("website_defaults_apartments.yml")
      end
    end

    context "Assisted Living" do
      let(:vertical) { "Assisted-Living" }

      it "loads the appropriate defaults" do
        expect(subject).to eq load_yaml("website_defaults_assisted_living.yml")
      end
    end

    context "everything else" do
      let(:vertical) { "foo" }

      it "loads the appropriate defaults" do
        expect(subject).to eq load_yaml("defaults.yml")
      end
    end
  end
end
