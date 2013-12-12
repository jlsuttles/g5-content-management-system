class UpdateNavigationWidgetsAndSettings < ActiveRecord::Migration
  def up
    Setting.navigation.destroy_all
    Widget.where(name: "Navigation").each do |widget|
      widget.send(:assign_attributes_from_url)
      widget.save
    end
    Website.all.each do |website|
      website.update_navigation_settings
    end
  end

  def down
  end
end
