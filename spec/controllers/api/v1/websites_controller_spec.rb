require "spec_helper"

describe Api::V1::WebsitesController do
  let(:website) { Fabricate(:website) }

  describe "#index" do
    before do
      WebsiteSerializer.new(website)
    end

    it "renders websites as json" do
      get :index
      expect(response.status).to eq 200
      pending("response.body JSON equals Website.all (after ran through the serializer and as JSON)")
    end
  end

  describe "#show" do
    it "finds website" do
      Website.should_receive(:find).with(website.id.to_s).once
      get :show, id: website.id
    end

    it "renders website as json" do
      get :show, id: website.id
      expect(response.body).to eq WebsiteSerializer.new(website).to_json
    end
  end

  describe "#update" do
    context "when update_attributes succeeds" do
      before do
        Website.any_instance.stub(:update_attributes) { true }
      end

      it "responds 200 OK" do
        put :update, id: website.id, website: { name: "lol" }
        expect(response.status).to eq 200
      end

      it "renders website as json" do
        put :update, id: website.id, website: { name: "lol" }
        expect(response.body).to eq WebsiteSerializer.new(website).to_json
      end
    end

    context "when update_attributes fails" do
      before do
        Website.any_instance.stub(:update_attributes) { false }
      end

      it "responds 422 UNPROCESSABLE" do
        put :update, id: website.id, website: { name: "lol" }
        expect(response.status).to eq 422
      end


      it "renders website errors as json" do
        put :update, id: website.id, website: { name: "lol" }
        expect(response.body).to eq "{}"
      end
    end

    context "allowed attributes" do
      it "custom_colors" do
        put :update, id: website.id, website: { custom_colors: true }
        expect(response.status).to eq 200
        expect(website.reload.custom_colors).to eq true
      end

      it "primary_color" do
        put :update, id: website.id, website: { primary_color: "lol" }
        expect(response.status).to eq 200
        expect(website.reload.read_attribute(:primary_color)).to eq "lol"
      end

      it "secondary_color" do
        put :update, id: website.id, website: { secondary_color: "lol" }
        expect(response.status).to eq 200
        expect(website.reload.read_attribute(:secondary_color)).to eq "lol"
      end
    end
  end
end
