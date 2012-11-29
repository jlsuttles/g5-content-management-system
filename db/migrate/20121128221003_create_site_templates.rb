class CreateSiteTemplates < ActiveRecord::Migration
  def change
    # create_table :site_templates do |t|
    #   t.belongs_to :location
    #   t.timestamps
    # end
    add_column :widgets, :section, :string
    add_column :pages, :template, :boolean, default: false
    # rename_column :widgets, :page_id, :template_id
    # add_column :widgets, :template_type, :string
  end
end