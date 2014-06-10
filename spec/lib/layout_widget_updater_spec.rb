require "spec_helper"

describe LayoutWidgetUpdater do
  let!(:widget) { Fabricate(:widget) }
  let!(:setting) { Fabricate(:setting, name: name, owner: widget) }
  let(:updater) { described_class.new(setting, name_settings, id_settings) }
  let(:name_settings) { SettingRowWidgetGardenWidgets::ROW_GARDEN_WIDGET_NAME_SETTINGS }
  let(:id_settings) { SettingRowWidgetGardenWidgets::ROW_WIDGET_ID_SETTINGS }

  describe "#update" do
    after { updater.update }

    context "a setting name not within name settings" do
      let(:name) { "Foo" }

      it "does not create a new widget" do
        updater.should_not_receive(:create_new_widget)
      end

      it "does not destroy the old widget" do
        updater.should_not_receive(:destroy_old_widget)
      end

      it "does not assign the new widget" do
        updater.should_not_receive(:assign_new_widget)
      end
    end

    context "a setting name within name settings" do
      let(:name) { name_settings[0] }

      it "creates a new widget" do
        updater.should_receive(:create_new_widget)
      end

      it "destroys the old widget" do
        updater.should_receive(:destroy_old_widget)
      end

      it "assigns the new widget" do
        updater.should_receive(:assign_new_widget)
      end
    end
  end
end
