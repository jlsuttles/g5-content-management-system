class Theme < ActiveRecord::Base
  attr_accessible :name, :url
  validates :url, presence: true
  def self.all_remote
    entries = G5HentryConsumer.parse("http://localhost:3002").entries
    entries.map do |entry|
      new(
        name: entry.name,
        url:  entry.bookmark
      )
    end
  end
  
end
