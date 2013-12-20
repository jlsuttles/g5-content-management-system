class ClientReaderJob
  extend HerokuResqueAutoscaler if Rails.env.production?
  @queue = :reader

  def self.perform(client_uid)
    ClientReader.new(client_uid).perform
  end
end
