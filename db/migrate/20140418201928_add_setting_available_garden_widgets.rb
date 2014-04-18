class AddSettingAvailableGardenWidgets < ActiveRecord::Migration
  def up
    Website.all.each do |website|
      website.settings.find_or_create_by_name!("available_garden_widgets", GardenWidgetSetting.new.value)
    end
  end

  def down
    Website.all.each do |website|
      website.settings.where(name: "available_garden_widgets").destroy_all
    end
  end
end
