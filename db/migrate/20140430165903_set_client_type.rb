class SetClientType < ActiveRecord::Migration
  def up
    client = Client.first
    client.type = "MultiDomainClient"
    client.save
  end

  def down
    client = Client.first
    client.type = nil
    client.save
  end
end
