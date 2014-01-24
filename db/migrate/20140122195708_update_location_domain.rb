class UpdateLocationDomain < ActiveRecord::Migration
  def up
    ClientReaderJob.perform(ENV["G5_CLIENT_UID"])
  end

  def down
  end
end
