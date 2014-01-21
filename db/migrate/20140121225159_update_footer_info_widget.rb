class UpdateFooterInfoWidget < ActiveRecord::Migration
  def up
    DropTarget.where(html_id: "drop-target-footer").each do |footer|
      footer.widgets.where(url: Widget.component_url("footer-info")).destroy_all
      footer.widgets.build(url: Widget.component_url("footer-info"))
      footer.save
     end
  end

  def down
  end
end
