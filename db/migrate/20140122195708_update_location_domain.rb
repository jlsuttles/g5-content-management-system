class UpdateLocationDomain < ActiveRecord::Migration
  def up
    ClientReader.new(ENV["G5_CLIENT_UID"]).perform
  end

  def down
  end
end
