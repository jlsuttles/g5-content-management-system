class AddAnalyticsWidgetToHead < ActiveRecord::Migration
  def change
    DropTarget.where(html_id: "drop-target-head").each do |head|
      head.widgets.build(url: Widget.component_url("analytics"))
      head.save
     end
     DropTarget.where(html_id: "drop-target-footer").each do |footer|
       footer.widgets.where(url: Widget.component_url("analytics")).destroy_all
       footer.save
    end
  end
end
