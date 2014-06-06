require 'spec_helper'

describe ColumnWidgetGardenWidgetsSetting do
  let!(:garden_widget) { Fabricate(:garden_widget) }
  let!(:row_widget) { Fabricate(:garden_widget, name: "Column") }

  describe "#value" do
    subject { described_class.new.value }

    it "does not include the Column widget" do
      subject.should eq([garden_widget.name])
    end
  end
end
