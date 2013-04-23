require 'spec_helper'

describe Setting do
  describe "#validation" do
    let(:setting) { Setting.create }
    it "must have a name" do
      setting.errors[:name].should include "can't be blank"
    end

    it "must belong to a owner" do
      setting.errors[:owner].should include "can't be blank"
    end
  end

  describe "#categories" do
    let(:setting) { Fabricate(:setting) }
    it "is an Array" do
      setting.reload
      setting.categories.should be_an_instance_of Array
    end
  end

  describe "others_with_higher_priority" do
    let(:setting0) { Fabricate(:setting, name: "same", value: "0", priority: 0) }
    let(:setting1) { Fabricate(:setting, name: "same", value: "1", priority: 1) }
    let(:setting2) { Fabricate(:setting, name: "same", value: "2", priority: 2) }

    it "returns empty when no others" do
      setting0.others_with_higher_priority.should be_empty
    end

    it "returns one when one other" do
      setting1.others_with_higher_priority.should eq [setting0]
    end

    it "returns two when two others" do
      setting2.others_with_higher_priority.should eq [setting1, setting0]
    end
  end

  describe "others_with_lower_priority" do
    let(:setting0) { Fabricate(:setting, name: "same", value: "0", priority: 0) }
    let(:setting1) { Fabricate(:setting, name: "same", value: "1", priority: 1) }
    let(:setting2) { Fabricate(:setting, name: "same", value: "2", priority: 2) }

    it "returns empty when no others" do
      setting2.others_with_lower_priority.should be_empty
    end

    it "returns one when one other" do
      setting1.others_with_lower_priority.should eq [setting2]
    end

    it "returns two when two others" do
      setting0.others_with_lower_priority.should eq [setting1, setting2]
    end
  end

  describe "#merge_value_with_lower_priority" do
    let(:setting0) { Fabricate(:setting, name: "same", priority: 0,
    value: {"0"=>{"display"=>false}}
    )}
    let(:setting1) { Fabricate(:setting, name: "same",
      value: [
        {"display"=>true, "title"=>"Homepage", "url"=>"/homepage"},
        {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
      ]
    )}
    let(:expected_value) {[
      {"display"=>false, "title"=>"Homepage", "url"=>"/homepage"},
      {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
    ]}
    it "does the expected thing" do
      setting0.merge_value_with_lower_priority(setting1).value.should eq expected_value
    end
  end

  describe "#merge_value_with_lower_priority" do
    let(:setting0) { Fabricate(:setting, name: "same", priority: 0,
      value: [
        {"display"=>false, "title"=>"Homepage", "url"=>"/homepage"},
      ]
    )}
    let(:setting1) { Fabricate(:setting, name: "same",
      value: [
        {"display"=>true, "title"=>"Homepage", "url"=>"/homepage"},
        {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
      ]
    )}
    let(:expected_value) {[
      {"display"=>false, "title"=>"Homepage", "url"=>"/homepage"},
      {"display"=>true, "title"=>"New Page", "url"=>"/new-page"}
    ]}
    it "does the expected thing" do
      setting0.merge_value_with_lower_priority(setting1).value.should eq expected_value
    end
  end
end
