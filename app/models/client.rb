class Client < ActiveRecord::Base
  include HasManySettings

  validates :uid, presence: true, uniqueness: true
  validates :name, presence: true

  def urn
    uid.split("/").last
  end

  def locations
    Location.all
  end

  def vertical_slug
    self.vertical.parameterize
  end
end
