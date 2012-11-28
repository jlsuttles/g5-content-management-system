class Widget < ActiveRecord::Base
  attr_accessible :html, :name, :page_id, :url, :position, :css, :javascript
  belongs_to :page
  validates :name, :url, presence: true
  before_create :set_html
  serialize :css, Array
  serialize :javascript, Array

  def self.all_remote
    entries = G5HentryConsumer.parse("http://g5-widget-garden.herokuapp.com").entries
    entries.map do |entry|
      new(
        name:        entry.name,
        url:         entry.bookmark,
        css:         entry.content.css.map(&:url).flatten,
        javascript:  entry.content.javascript.map(&:url).flatten
      )
    end
  end

  private

  def set_html
    self.html = parse_html
  end

  def parse_html
    Nokogiri::HTML(get_html).at_css('.widget').children.to_html
  end

  def get_html
    open(self.url).read
  end


end
