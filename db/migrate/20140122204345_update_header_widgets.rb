class UpdateHeaderWidgets < ActiveRecord::Migration
  def up
    DropTarget.where(html_id: "drop-target-phone").each do |phone|
      phone.widgets.where(url: Widget.component_url("phone")).destroy_all
      phone.widgets.build(url: Widget.component_url("phone"))
      phone.save
    end
    DropTarget.where(html_id: "drop-target-btn").each do |btn|
      btn.widgets.where(url: Widget.component_url("btn")).destroy_all
      btn.widgets.build(url: Widget.component_url("btn"))
      btn.save
    end
  end

  def down
  end
end
