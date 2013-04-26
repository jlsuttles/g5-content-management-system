require 'spec_helper'

describe "WebHomeTemplate" do
  let (:web_home_template) { Fabricate.build(:web_home_template) }

  describe ".type_for_route" do
    it "should use its own type" do
      web_home_template.type_for_route.should == web_home_template.type
    end
  end  
end  
