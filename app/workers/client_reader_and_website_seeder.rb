class ClientReaderAndWebsiteSeeder
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :deploy

  def self.perform(client_uid)
    ClientReader.perform(client_uid)
    WebsiteSeeder.perform
  end
end
