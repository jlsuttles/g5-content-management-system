class AddSlugToPages < ActiveRecord::Migration
  def change
    add_column :pages, :slug, :string
    add_column :widgets, :thumbnail, :string
    add_column :page_layouts, :thumbnail, :string
    add_column :themes, :thumbnail, :string
  end
end