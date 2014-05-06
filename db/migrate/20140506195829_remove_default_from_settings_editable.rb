class RemoveDefaultFromSettingsEditable < ActiveRecord::Migration
  def up
    change_column :settings, :editable, :boolean, default: nil
  end

  def down
    change_column :settings, :editable, :boolean, default: false
  end
end
