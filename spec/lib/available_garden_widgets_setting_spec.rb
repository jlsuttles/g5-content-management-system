require 'spec_helper'

describe AvailableGardenWidgetsSetting do
  let!(:garden_widget) { Fabricate(:garden_widget) }

  describe "#value" do
    subject { described_class.new.value }

    it { should eq([[garden_widget.name]]) }
  end
end
