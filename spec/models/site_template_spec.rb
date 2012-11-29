require 'spec_helper'

describe SiteTemplate do
  let(:template) { SiteTemplate.new }

  its(:header_widgets) { should eq [] }
  its(:aside_widgets) { should eq [] }
  its(:footer_widgets) { should eq [] }
end
