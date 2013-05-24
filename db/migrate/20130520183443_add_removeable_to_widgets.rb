class AddRemoveableToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :removeable, :boolean
  end
end
