require 'spec_helper'

describe ClientServices do
  let!(:client) { Fabricate(:client) }

  before do
    @client_services = ClientServices.new
    @heroku_app_max_length = ClientServices::HEROKU_APP_NAME_MAX_LENGTH
  end

  describe "#client" do
    it "grabs the first client" do
      @client_services.client.should == client
    end
  end

  describe "#client_urn" do
    it "grabs the client_urn" do
      @client_services.client_urn.should == client.urn
    end
  end

  describe "#client_app_name" do
    it "grabs the client_app_name" do
      @client_services.client_app_name.should == client.urn[0...@heroku_app_max_length]
    end
  end

  describe "#client_url" do
    it "grabs the client_url" do
      @client_services.client_url.should == "http://#{@client_services.client_app_name}.herokuapp.com/"
    end
  end

  describe "#client_location_urns" do
    it "grabs the client_location_urns" do
      location_urns = client.locations.map(&:urn)
      @client_services.client_location_urns.should == location_urns
    end
  end

  describe "#client_location_urls" do
    it "grabs the client_location_urls" do
      location_urls = client.locations.map(&:domain)
      @client_services.client_location_urls.should == location_urls
    end
  end

  describe "services" do
    ClientServices::SERVICES.each do |service|
      describe "#{service}_urn" do
        it "grabs the #{service}_urn" do
          @client_services.send(:"#{service}_urn").should == client.urn.gsub(/-c-/, "-#{service}-")
        end
      end

      describe "#{service}_app_name" do
        it "grabs the #{service}_app_name" do
          @client_services.send(:"#{service}_app_name").should == client.urn.gsub(/-c-/, "-#{service}-")[0...@heroku_app_max_length]
        end
      end

      describe "#{service}_url" do
        it "grabs the #{service}_url" do
          @client_services.send(:"#{service}_url").should == "http://" + client.urn.gsub(/-c-/, "-#{service}-")[0...@heroku_app_max_length] + ".herokuapp.com/"
        end
      end
    end
  end
end
