class UpdateDefaultFooterWidgets < ActiveRecord::Migration
  def up
    DropTarget.where(html_id: "drop-target-footer").each do |footer|
      footer.widgets.build(url: Widget.component_url("footer-info"))
      footer.widgets.where(url: Widget.component_url("photo")).destroy_all
      footer.save
   end
  end

  def down
  end
end
