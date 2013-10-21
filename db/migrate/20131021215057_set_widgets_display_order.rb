class SetWidgetsDisplayOrder < ActiveRecord::Migration
  def up
    DropTarget.all.each do |drop_target|
      drop_target.widgets.each_with_index do |widget, index|
        widget.update_attribute(:display_order, index)
      end
    end
  end

  def down
  end
end
