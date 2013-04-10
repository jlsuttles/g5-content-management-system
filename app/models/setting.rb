require_dependency "hash_with_to_liquid"

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

  serialize :value
  serialize :categories, Array

  belongs_to :owner, polymorphic: true

  before_create :set_priority
  before_update :next_value_merge, if: :navigation?

  validates :name, presence: true
  validates :owner, presence: true
  validates :owner_type, presence: true, inclusion: { in: PRIORITIZED_OWNERS }
  # validates :priority, presence: true, numericality: { only_integer: true }

  def best_value
    prioritized_value || value
  end

  def navigation?
    name == "navigation"
  end

  def prioritized_value
    self.class.
      where(name: name).
      where("value IS NOT NULL").
      where("priority >= ?", owner.priority).
      order("priority ASC").
      first.
      try(:value)
  end

  def next_value
    self.class.
      where(name: name).
      where("value IS NOT NULL").
      where("priority > ?", owner.priority).
      order("priority ASC").
      first.
      try(:value)
  end

  def next_value_merge
    if next_value
      new_value = []
      value.each_pair do |k,v|
        new_value << HashWithToLiquid[next_value[k.to_i].merge(v)]
      end
      self.value = new_value
    end
  end

  private

  def set_priority
    self.priority = PRIORITIZED_OWNERS.index(owner_type)
  end
end
