class RenameIndiciesForWebTemplates < ActiveRecord::Migration
  def up
    rename_index :web_layouts, :index_page_layouts_on_page_id, :index_web_layouts_on_web_template_id
    rename_index :web_templates, :index_pages_on_location_id, :index_web_templates_on_website_id
    rename_index :web_themes, :index_themes_on_page_id, :index_web_themes_on_web_template_id
    rename_index :widgets, :index_widgets_on_page_id, :index_widgets_on_web_template_id
  end

  def down
    rename_index :web_layouts, :index_web_layouts_on_web_template_id, :index_page_layouts_on_page_id
    rename_index :web_templates, :index_web_templates_on_website_id, :index_pages_on_location_id
    rename_index :web_themes, :index_web_themes_on_web_template_id, :index_themes_on_page_id
    rename_index :widgets, :index_widgets_on_web_template_id, :index_widgets_on_page_id
  end
end
