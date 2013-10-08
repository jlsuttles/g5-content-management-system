require "spec_helper"

describe Api::V1::WebThemesController do
  let(:web_theme) { Fabricate(:web_theme) }

  describe "#show" do
    it "finds web_theme" do
      WebTheme.should_receive(:find).with(web_theme.id.to_s).once
      get :show, id: web_theme.id
    end

    it "renders web_theme as json" do
      get :show, id: web_theme.id
      expect(response.body).to eq WebThemeSerializer.new(web_theme).to_json
    end
  end

  describe "#update" do
    context "when update_attributes succeeds" do
      before do
        WebTheme.any_instance.stub(:update_attributes) { true }
      end

      it "responds 200 OK" do
        put :update, id: web_theme.id, web_theme: { name: "lol" }
        expect(response.status).to eq 200
      end

      it "renders web_theme as json" do
        put :update, id: web_theme.id, web_theme: { name: "lol" }
        expect(response.body).to eq WebThemeSerializer.new(web_theme).to_json
      end
    end

    context "when update_attributes fails" do
      before do
        WebTheme.any_instance.stub(:update_attributes) { false }
      end

      it "responds 422 UNPROCESSABLE" do
        put :update, id: web_theme.id, web_theme: { name: "lol" }
        expect(response.status).to eq 422
      end


      it "renders web_theme errors as json" do
        put :update, id: web_theme.id, web_theme: { name: "lol" }
        expect(response.body).to eq "{}"
      end
    end

    context "allowed attributes" do
      it "url" do
        put :update, id: web_theme.id, web_theme: { url: WebThemeSupport.web_theme.url }
        expect(response.status).to eq 200
        expect(web_theme.reload.url).to eq WebThemeSupport.web_theme.url
      end
    end
  end
end
