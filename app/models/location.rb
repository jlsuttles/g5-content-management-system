class Location < ActiveRecord::Base
  include HasManySettings
  include AfterCreateUpdateUrn
  include ToParamUrn

  set_urn_prefix "g5-cl"

  has_one :website, dependent: :destroy
  has_one :web_home_template, through: :website

  validates :uid, presence: true, uniqueness: true
  validates :urn, presence: true, uniqueness: true, unless: :new_record?
  validates :name, presence: true

  before_create :build_website

  def website_id
    website.try(:id)
  end
end
