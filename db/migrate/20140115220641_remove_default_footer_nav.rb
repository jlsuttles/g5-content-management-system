class RemoveDefaultFooterNav < ActiveRecord::Migration
  def up
    DropTarget.where(html_id: "drop-target-footer").each do |footer|
      footer.widgets.where(url: Widget.component_url("navigation")).destroy_all
      footer.save
    end
  end

  def down
  end
end
