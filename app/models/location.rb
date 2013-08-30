class Location < ActiveRecord::Base
  include HasManySettings
  include AfterCreateUpdateUrn
  include ToParamUrn

  set_urn_prefix "g5-cl"

  has_one :website, dependent: :destroy

  validates :uid, presence: true, uniqueness: true
  validates :urn, presence: true, uniqueness: true, unless: :new_record?
  validates :name, presence: true

  def website_id
    website.try(:id)
  end
end
