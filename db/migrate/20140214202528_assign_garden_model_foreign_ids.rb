class AssignGardenModelForeignIds < ActiveRecord::Migration
  def up
    # Make sure GardenWebLayouts are up to date
    GardenWebLayoutUpdater.new.update_all
    # Find the corresponding GardenWebLayout for each WebLayout
    WebLayout.all.each do |web_layout|
      url = web_layout.read_attribute(:url)
      garden_web_layout = GardenWebLayout.find_by_url(url)
      web_layout.garden_web_layout_id = garden_web_layout.try(:id)
      web_layout.save
    end

    # Make sure GardenThemes are up to date
    GardenWebThemeUpdater.new.update_all
    # Find the corresponding GardenTheme for each Theme
    WebTheme.all.each do |web_theme|
      url = web_theme.read_attribute(:url)
      garden_web_theme = GardenWebTheme.find_by_url(url)
      web_theme.garden_web_theme_id = garden_web_theme.try(:id)
      web_theme.save
    end

    # Make sure GardenWidgets are up to date
    GardenWidgetUpdater.new.update_all
    # Find the corresponding GardenWidget for each Widget
    Widget.all.each do |widget|
      url = widget.read_attribute(:url)
      garden_widget = GardenWidget.find_by_url(url)
      widget.garden_widget_id = garden_widget.try(:id)
      widget.save
    end
  end

  def down
  end
end
