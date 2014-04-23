require File.dirname(__FILE__) + '/../spec_helper'

describe Client do
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

  describe "Web Page Defaults" do
    it "website defaults are for self-storage if vertical is self-storage" do
      @client = Fabricate(:client, vertical: "Self-Storage")
      expect(@client.website_defaults).to eq YAML.load_file("#{Rails.root}/config/website_defaults_self_storage.yml")
    end

    it "website defaults are for apartments if vertical is apartments" do
      @client = Fabricate(:client, vertical: "Apartments")
      expect(@client.website_defaults).to eq YAML.load_file("#{Rails.root}/config/website_defaults_apartments.yml")
    end

    it "website defaults are for assisted-living if vertical is assisted-living" do
      @client = Fabricate(:client, vertical: "Assisted-Living")
      expect(@client.website_defaults).to eq YAML.load_file("#{Rails.root}/config/website_defaults_assisted_living.yml")
    end
  end
end
