class Client < ActiveRecord::Base
  include HasManySettings

  validates :uid, presence: true, uniqueness: true
  validates :name, presence: true
  validates :vertical, presence: true

  def urn
    uid.split("/").last
  end

  def locations
    Location.all
  end

  def vertical_slug
    vertical.try(:parameterize).to_s
  end

  def website_defaults
    case vertical
    when 'Assisted-Living'
      WEBSITE_DEFAULTS_ASSISTED_LIVING
    when 'Self-Storage'
      WEBSITE_DEFAULTS_SELF_STORAGE
    when 'Apartments'
      WEBSITE_DEFAULTS_APARTMENTS
    end
  end
end
