class SetWebsiteOwnerType < ActiveRecord::Migration
  def up
    Website.all.each { |website| website.update_attributes!(owner_type: "Location") }
  end

  def down
    Website.all.each { |website| website.update_attributes!(owner_type: nil) }
  end
end
