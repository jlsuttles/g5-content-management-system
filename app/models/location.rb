class Location < ActiveRecord::Base
  include PrioritizedSettings
  include SettingNavigationLinks

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

  after_create :set_urn

  def record_type
    "g5-cl"
  end

  def to_param
    urn
  end

  private

  def set_urn
    update_attributes(urn: "#{record_type}-#{id}-#{name.parameterize}")
  end
end
