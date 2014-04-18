require 'spec_helper'

describe GardenWidgetsSetting do
  let!(:garden_widget) { Fabricate(:garden_widget) }

  subject { GardenWidgetsSetting.new.value }

  it { should eq([[garden_widget.id, garden_widget.name]]) }
end
