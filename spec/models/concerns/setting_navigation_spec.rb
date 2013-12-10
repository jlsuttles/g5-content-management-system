require "spec_helper"

shared_examples_for SettingNavigation do
  let(:described_instance) { described_class.new }

  describe "When display changes on widget" do
    let(:website_value) {[
        {"display"=>true, "title"=>"Homepage", "url"=>"/homepage"},
        {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
      ]}
    let(:widget_value) {
      {"0"=>{"display"=>false}, "1"=>{"display"=>true}}
    }
    let(:expected_value) {[
      {"display"=>false, "title"=>"Homepage", "url"=>"/homepage"},
      {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
    ]}

    it "Keeps new display value" do
      described_instance.create_new_value(website_value, widget_value).should eq expected_value
    end
  end

  describe "When the title changes on website" do
    let(:widget_value) {[
        {"display"=>false, "title"=>"Old Title", "url"=>"/old-title"},
      ]}
    let(:website_value) {[
        {"display"=>true, "title"=>"New Title", "url"=>"/new-title"},
        {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
      ]}
    let(:expected_value) {[
      {"display"=>false, "title"=>"New Title", "url"=>"/new-title"},
      {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
    ]}

    it "Keeps new title and old display value" do
      described_instance.create_new_value(website_value, widget_value).should eq expected_value
    end
  end
end

describe Setting do
  it_behaves_like SettingNavigation
end

