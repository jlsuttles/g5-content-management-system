class PageLayout < ActiveRecord::Base
  attr_accessible :html, :name, :page_id, :url
  validates :url, presence: true
  before_save :set_html
  def self.all_remote
    entries = G5HentryConsumer.parse("http://g5-layout-garden.herokuapp.com/").entries
    entries.map do |entry|
      new(
        name: entry.name,
        url:  entry.bookmark
      )
    end
  end
  
  private
  
  def set_html
    self.html = parse_html
  end
  
  def parse_html
    Nokogiri::HTML(get_html).at_css('body').to_html
  end
  
  def get_html
    open(self.url).read
  end
  
  
end
