require 'spec_helper'

describe ClientReader do

  describe "#perform" do
    let(:perform) { ClientReader.perform("spec/support/client.html") }

    it "creates 1 client" do
      expect { perform }.to change(Client, :count).by(1)
    end
    it "creates 2 locations" do
      expect { perform }.to change(Location, :count).by(2)
    end
  end
end
