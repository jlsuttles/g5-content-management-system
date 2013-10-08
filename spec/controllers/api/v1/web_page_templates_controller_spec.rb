require "spec_helper"

describe Api::V1::WebPageTemplatesController do
  let(:web_page_template) { Fabricate(:web_page_template) }
  let(:main_drop_target) { Fabricate(:drop_target) }

  before do
    web_page_template.drop_targets << main_drop_target
  end

  describe "#show" do
    it "finds web page template" do
      WebPageTemplate.should_receive(:find).with(web_page_template.id.to_s).once
      get :show, id: web_page_template.id
    end

    it "renders web page template as json" do
      get :show, id: web_page_template.id
      expect(response.body).to eq WebPageTemplateSerializer.new(web_page_template).to_json
    end
  end
end
