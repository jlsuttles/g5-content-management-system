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

  serialize :categories

  belongs_to :owner, polymorphic: true

  before_validation :set_priority

  validates :name, presence: true
  validates :owner, presence: true
  validates :owner_type, presence: true, inclusion: { in: PRIORITIZED_OWNERS }
  validates :priority, presence: true, numericality: { only_integer: true }

  private

  def set_priority
    self.priority = PRIORITIZED_OWNERS.index(owner_type)
  end
end
