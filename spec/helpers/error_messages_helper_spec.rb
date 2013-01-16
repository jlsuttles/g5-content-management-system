require 'spec_helper'

describe ErrorMessagesHelper do
  before do
    @object = Widget.new
    @object.valid?
    @builder = ActionView::Helpers::FormBuilder.new(:widget, @object, self, {}, nil)
  end
  describe "#error_messages_for" do
    it "has an error messages div" do
      @builder.error_messages.should match "<div class=\"error_messages\">"
    end
    
    it "has the objects error" do
      @builder.error_messages.should match "Url can&#x27;t be blank"
    end
  end
end