require 'spec_helper'

describe GardenWidgetsSetting do
  let!(:garden_widget) { Fabricate(:garden_widget) }

  describe "#value" do
    subject { described_class.new.value }

    it { should eq([[garden_widget.id, garden_widget.name]]) }
  end
end
