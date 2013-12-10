require "spec_helper"

shared_examples_for SettingNavigation do
  # let(:described_instance) { described_class.new }

  # describe "#merge_value_with_lower_priority" do
  #   let(:setting0) { Fabricate(:setting, name: "same", priority: 0,
  #   value: {"0"=>{"display"=>false}}
  #   )}
  #   let(:setting1) { Fabricate(:setting, name: "same",
  #     value: [
  #       {"display"=>true, "title"=>"Homepage", "url"=>"/homepage"},
  #       {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
  #     ]
  #   )}
  #   let(:expected_value) {[
  #     {"display"=>false, "title"=>"Homepage", "url"=>"/homepage"},
  #     {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
  #   ]}
  #   it "does the expected thing" do
  #     setting0.merge_value_with_lower_priority(setting1).value.should eq expected_value
  #   end
  # end

  # describe "#merge_value_with_lower_priority" do
  #   let(:setting0) { Fabricate(:setting, name: "same", priority: 0,
  #     value: [
  #       {"display"=>false, "title"=>"Homepage", "url"=>"/homepage"},
  #     ]
  #   )}
  #   let(:setting1) { Fabricate(:setting, name: "same",
  #     value: [
  #       {"display"=>true, "title"=>"Homepage", "url"=>"/homepage"},
  #       {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
  #     ]
  #   )}
  #   let(:expected_value) {[
  #     {"display"=>false, "title"=>"Homepage", "url"=>"/homepage"},
  #     {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
  #   ]}
  #   it "does the expected thing" do
  #     setting0.merge_value_with_lower_priority(setting1).value.should eq expected_value
  #   end
  # end

  # describe "#merge_value_with_lower_priority" do
  #   let(:setting0) { Fabricate(:setting, name: "same",
  #     value: [
  #       {"display"=>false, "title"=>"Old Title", "url"=>"/old-title"},
  #     ]
  #   )}
  #   let(:setting1) { Fabricate(:setting, name: "same",
  #     value: [
  #       {"display"=>true, "title"=>"New Title", "url"=>"/new-title"},
  #       {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
  #     ]
  #   )}
  #   let(:expected_value) {[
  #     {"display"=>false, "title"=>"New Title", "url"=>"/new-title"},
  #     {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
  #   ]}
  #   it "only updates display" do
  #     setting0.merge_value_with_lower_priority(setting1).value.should eq expected_value
  #   end
  # end
end

describe Setting do
  it_behaves_like SettingNavigation
end

