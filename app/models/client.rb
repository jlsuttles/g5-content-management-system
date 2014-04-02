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
      instructions = WEBSITE_DEFAULTS_ASSISTED_LIVING
    when 'Self-Storage'
      instructions = WEBSITE_DEFAULTS_SELF_STORAGE
    when 'Apartments'
      instructions = WEBSITE_DEFAULTS_APARTMENTS
    end
  end
end
