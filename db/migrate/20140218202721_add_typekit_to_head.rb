class AddTypekitToHead < ActiveRecord::Migration
  def change
    DropTarget.where(html_id: "drop-target-head").each do |head|
      head.widgets.build(url: Widget.component_url("typekit"))
      head.save
   end
  end
end
