class RemoveHeaderPhoneWidget < ActiveRecord::Migration
  def up
    DropTarget.where(html_id: "drop-target-phone").each do |phone|
      phone.widgets.where(url: Widget.component_url("phone")).destroy_all
      phone.save
    end
    DropTarget.where(html_id: "drop-target-phone").destroy_all
  end

  def down
  end
end
