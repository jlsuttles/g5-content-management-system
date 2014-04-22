require "spec_helper"

shared_examples_for SettingAvailableGardenWidgets do
  describe "When availble_garden_widgets setting" do
    let(:widget) { Fabricate(:widget) }
    let(:described_instance) { described_class.new(name: SettingAvailableGardenWidgets::SELECTED_GARDEN_WIDGET_SETTING_NAMES[0], owner: widget) }
    let(:corresponding_setting) { Setting.new(name: SettingAvailableGardenWidgets::WIDGET_ID_SETTING_NAMES[0], owner: widget) }

    describe "After update" do
      it "Tries to update corresponding setting" do
        described_instance.should_receive(:update_widget_id_setting)
        described_instance.save
      end

      describe "When value does not change" do
        it "Does not update corresponding setting" do
          expect { described_instance.save }.to_not change { corresponding_setting.value }
        end
      end

      describe "When value changes" do
        before { corresponding_setting.value = "Foo" }

        it "Updates corresponding setting" do
          expect { described_instance.save }.to change { corresponding_setting.value }
        end
      end
    end
  end

  describe "When not an avaiable_garden_widgets setting" do
    let(:described_instance) { described_class.new(name: "foo") }

    describe "After update" do
      it "Does not try to update corresponding setting" do
        described_instance.should_not_receive(:update_widget_id_setting)
        described_instance.save
      end
    end
  end
end

describe Setting do
  it_behaves_like SettingAvailableGardenWidgets
end
