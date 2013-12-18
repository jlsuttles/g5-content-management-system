class AddRedirectPatternsToWebTemplates < ActiveRecord::Migration
  def change
    add_column :web_templates, :redirect_patterns, :string
  end
end
