class Location < ActiveRecord::Base
  include HasManySettings
  include ToParamUrn

  has_one :website, as: :owner, dependent: :destroy

  validates :uid, presence: true, uniqueness: true
  validates :urn, presence: true, uniqueness: true
  validates :name, presence: true
  validates :city, presence: true
  validates :state, presence: true

  scope :corporate, -> { where(corporate: true).first }

  before_validation :set_city_slug_from_city

  def website_id
    website.try(:id)
  end

  def state_slug
    state.try(:parameterize).to_s
  end

  def neighborhood_slug
    neighborhood.try(:parameterize).to_s
  end

  private

  def set_city_slug_from_city
    self.city_slug = city.to_s.parameterize
  end
end
