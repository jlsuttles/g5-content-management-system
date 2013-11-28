class SetWebTemplatesDisplayOrder < ActiveRecord::Migration
  def up
    Website.all.each do |website|
      website.web_templates.each_with_index do |web_template, index|
        web_template.update_attribute(:display_order, index)
      end
    end
  end

  def down
  end
end
