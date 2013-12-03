class Location < ActiveRecord::Base
  include HasManySettings
  include ToParamUrn

  has_one :website, dependent: :destroy

  validates :uid, presence: true, uniqueness: true
  validates :urn, presence: true, uniqueness: true
  validates :name, presence: true

  def website_id
    website.try(:id)
  end
end
