class UpdateNavWidget < ActiveRecord::Migration
  def up
    DropTarget.where(html_id: "drop-target-nav").each do |head|
      head.widgets.where(url: Widget.component_url("navigation")).destroy_all
      head.widgets.build(url: Widget.component_url("navigation"))
      head.save
    end
  end

  def down
  end
end
