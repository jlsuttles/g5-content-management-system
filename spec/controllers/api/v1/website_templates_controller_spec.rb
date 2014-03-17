require "spec_helper"

describe Api::V1::WebsiteTemplatesController, :auth_controller do
  let(:website_template) { Fabricate(:website_template) }
  let(:web_layout) { Fabricate(:web_layout) }
  let(:web_theme) { Fabricate(:web_theme) }
  let(:head_drop_target) { Fabricate(:head_drop_target) }
  let(:logo_drop_target) { Fabricate(:logo_drop_target) }
  let(:phone_drop_target) { Fabricate(:phone_drop_target) }
  let(:btn_drop_target) { Fabricate(:btn_drop_target) }
  let(:nav_drop_target) { Fabricate(:nav_drop_target) }
  let(:aside_drop_target) { Fabricate(:aside_drop_target) }
  let(:footer_drop_target) { Fabricate(:footer_drop_target) }

  before do
    website_template.drop_targets << head_drop_target
    website_template.drop_targets << logo_drop_target
    website_template.drop_targets << phone_drop_target
    website_template.drop_targets << btn_drop_target
    website_template.drop_targets << nav_drop_target
    website_template.drop_targets << aside_drop_target
    website_template.drop_targets << footer_drop_target
  end

  describe "#show" do
    it "finds website template" do
      WebsiteTemplate.should_receive(:find).with(website_template.id.to_s).once
      get :show, id: website_template.id
    end

    it "renders website template as json" do
      get :show, id: website_template.id
      expect(response.body).to eq WebsiteTemplateSerializer.new(website_template).to_json
    end
  end
end
