class Location < ActiveRecord::Base
  include HasManyPrioritizedSettings
  include AfterCreateUpdateUrn
  include ToParamUrn

  set_urn_prefix "g5-cl"

  attr_accessible :uid,
                  :urn,
                  :name,
                  :corporate

  has_one :website, dependent: :destroy
  # TODO: remove these, requires changes elsewhere
  has_one :website_template    , through: :website
  has_one :web_home_template   , through: :website
  has_many :web_page_templates , through: :website
  has_many :web_templates      , through: :website

  validates :uid, presence: true, uniqueness: true
  validates :urn, presence: true, uniqueness: true
  validates :name, presence: true

  before_create :build_website
end
