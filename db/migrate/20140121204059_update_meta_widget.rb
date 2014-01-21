class UpdateMetaWidget < ActiveRecord::Migration
  def up
    DropTarget.where(html_id: "drop-target-head").each do |head|
      head.widgets.where(url: Widget.component_url("meta")).destroy_all
      head.widgets.where(url: Widget.component_url("analytics")).destroy_all
      head.widgets.build(url: Widget.component_url("meta"))
      head.widgets.build(url: Widget.component_url("analytics"))
      head.save
     end
  end

  def down
  end
end
