class Setting < ActiveRecord::Base
  PRIORITIZED_OWNERS = [
    "Widget",
    "WebTemplate",
    "WebPageTemplate",
    "WebsiteTemplate",
    "WebLayout",
    "WebTheme",
    "Website",
    "Location",
    "Client"
  ]

  attr_accessible :owner_id,
                  :owner_type,
                  :name,
                  :editable,
                  :value,
                  :default_value,
                  :categories,
                  :priority

  serialize :categories, Array

  belongs_to :owner, polymorphic: true

  before_validation :set_priority

  validates :name, presence: true
  validates :owner, presence: true
  validates :owner_type, presence: true, inclusion: { in: PRIORITIZED_OWNERS }
  validates :priority, presence: true, numericality: { only_integer: true }

  def value
    prioritized_value || read_attribute(:value)
  end

  def prioritized_value
    Setting.
      where(name: name).
      where("value IS NOT NULL").
      where("priority >= ?", owner.priority).
      order("priority ASC").
      first.
      try(:read_attribute, :value)
  end

  private

  def set_priority
    self.priority = PRIORITIZED_OWNERS.index(owner_type)
  end
end
