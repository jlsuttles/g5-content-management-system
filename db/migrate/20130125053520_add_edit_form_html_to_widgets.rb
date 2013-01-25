class AddEditFormHtmlToWidgets < ActiveRecord::Migration
  def change
    add_column :widgets, :edit_form_html, :text
  end
end
