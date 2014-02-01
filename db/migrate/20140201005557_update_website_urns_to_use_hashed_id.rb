class UpdateWebsiteUrnsToUseHashedId < ActiveRecord::Migration
  def up
    Website.all.each do |website|
      website.send(:update_urn)
    end
  end

  def down
  end
end
