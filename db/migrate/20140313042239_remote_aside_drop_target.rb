class RemoteAsideDropTarget < ActiveRecord::Migration
  def up
    # Remove old Aside drop targets
    DropTarget.where(html_id: "drop-target-aside").each do |phone|
      phone.widgets.where(url: Widget.component_url("aside")).destroy_all
      phone.save
    end
    DropTarget.where(html_id: "drop-target-aside").destroy_all
  end

  def down
  end
end
