class Location < ActiveRecord::Base
  include HasManySettings
  include AfterCreateUpdateUrn
  include ToParamUrn

  set_urn_prefix "g5-cl"

  attr_accessible :uid,
                  :urn,
                  :name,
                  :corporate

  has_one :website, dependent: :destroy

  validates :uid, presence: true, uniqueness: true
  validates :urn, presence: true, uniqueness: true, unless: :new_record?
  validates :name, presence: true

  before_create :build_website
end
