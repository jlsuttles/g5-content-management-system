class AddAndUpdateWidgetSettings < ActiveRecord::Migration
  def up
    WebsiteSeederJob.perform
  end

  def down
  end
end
