class Location < ActiveRecord::Base
  #TODO remove this if location will not have a concept of address
  liquid_methods :address

  attr_accessible :uid,
                  :urn,
                  :name,
                  :corporate

  has_one :website
  has_one :website_template, through: :website
  has_many :web_page_templates, through: :website
  has_many :web_templates, through: :website

  after_create :set_urn
  before_create :build_website

  #TODO remove this if location will not have a concept of address
  def address
    "12345 greenwood ave, bend OR"
  end

  def record_type
    "g5-cl"
  end

  def hashed_id
    "#{self.created_at.to_i}#{self.id}".to_i.to_s(36)
  end

  def to_param
    self.urn
  end

  private

  def set_urn
    update_attributes(urn: "#{record_type}-#{hashed_id}-#{name.parameterize}")
  end
end
