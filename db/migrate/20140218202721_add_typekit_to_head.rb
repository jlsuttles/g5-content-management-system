class AddTypekitToHead < ActiveRecord::Migration
  def change
    # Make sure the typekit widget has been added to the database
    GardenWidgetUpdater.new.update_all
    # Find the GardenWidget (These are like the remote wigets, but they aren't remote anymore)
    garden_widget = GardenWidget.where(url: GardenWidget.component_url("typekit"))
    # Create the new widgets in the head
    DropTarget.where(html_id: "drop-target-head").each do |head|
      widget = head.widgets.build(garden_widget_id: garden_widget.id)
      widget.save
      widget.update_attribue(:display_order_position, 1)
   end
  end
end
