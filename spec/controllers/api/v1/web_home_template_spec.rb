require "spec_helper"

describe Api::V1::WebHomeTemplatesController do
  let(:web_home_template) { Fabricate(:web_home_template) }
  let(:main_drop_target) { Fabricate(:drop_target) }

  before do
    web_home_template.drop_targets << main_drop_target
  end

  describe "#show" do
    it "finds web home template" do
      WebHomeTemplate.should_receive(:find).with(web_home_template.id.to_s).once
      get :show, id: web_home_template.id
    end

    it "renders web home template as json" do
      get :show, id: web_home_template.id
      expect(response.body).to eq WebHomeTemplateSerializer.new(web_home_template).to_json
    end
  end
end
