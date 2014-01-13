class UpdateCtaAndNavigationWidgets < ActiveRecord::Migration
  def up
    # Update all navigation widgets
    Widget.where(name: "Navigation").each do |widget|
      widget.url = Widget.component_url("navigation")
      widget.assign_attributes_from_url
      widget.save
    end
    # Change all CTA widgets to navigation widgets
    Widget.where(name: "Calls to Action").each do |widget|
      widget.settings.destroy_all
      widget.url = Widget.component_url("navigation")
      widget.assign_attributes_from_url
      widget.save
      widget.settings.where(name: "display_as_calls_to_action").each do |setting|
        setting.update_attribute(:value, "true")
      end
    end
  end

  def down
  end
end
